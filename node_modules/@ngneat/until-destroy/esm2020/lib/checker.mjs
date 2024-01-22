import { ɵglobal, ɵgetLContext } from '@angular/core';
import { EMPTY, from, Subject } from 'rxjs';
import { mergeMap } from 'rxjs/operators';
// `LView` is an array where each index matches the specific data structure.
// The 7th element in an `LView` is an array of cleanup listeners. They are
// invoked when the view is removed (similar to `ComponentRef.onDestroy`).
const CLEANUP = 7;
const CheckerHasBeenSet = Symbol('CheckerHasBeenSet');
export function setupSubjectUnsubscribedChecker(instance, destroy$) {
    // This function is used within the `untilDestroyed` operator and setups a function that
    // listens for the view removal and checks if the `destroy$` subject has any observers (usually `takeUntil`).
    // Note: this code will not be shipped into production since it's guarded with `ngDevMode`,
    // this means it'll exist only in development mode.
    if (instance[CheckerHasBeenSet] || isAngularInTestMode()) {
        return;
    }
    runOutsideAngular(() => from(Promise.resolve())
        .pipe(mergeMap(() => {
        let lContext;
        try {
            // The `ɵgetLContext` might not work for a pipe, because it's not a component nor a directive,
            // which means there's no `RNode` for an instance.
            lContext = ɵgetLContext(instance);
        }
        catch {
            lContext = null;
        }
        const lView = lContext?.lView;
        if (lView == null) {
            return EMPTY;
        }
        const lCleanup = lView[CLEANUP] || (lView[CLEANUP] = []);
        const cleanupHasBeenExecuted$ = new Subject();
        // Note: this function is named for debugging purposes.
        lCleanup.push(function untilDestroyedLCleanup() {
            // We leave the Angular zone, so RxJS will also call subsequent `next` functions
            // outside of the Angular zone, which is done to avoid scheduling a microtask (through
            // `asapScheduler`) within the Angular zone.
            runOutsideAngular(() => {
                cleanupHasBeenExecuted$.next();
                cleanupHasBeenExecuted$.complete();
            });
        });
        return cleanupHasBeenExecuted$;
    }), 
    // We can't use `observeOn(asapScheduler)` because this might break the app's change detection.
    // RxJS schedulers coalesce tasks and then flush the queue, which means our task might be scheduled
    // within the root zone, and then all of the tasks (that were set up by developers in the Angular zone)
    // will also be flushed in the root zone.
    mergeMap(() => Promise.resolve()))
        .subscribe(() => {
        // Note: The `observed` property is available only in RxJS@7.2.0, which will throw
        // an error in lower versions. We have integration test with RxJS@6 to ensure we don't
        // import operators from `rxjs`; that's why it's wrapped into braces. The `observers`
        // property is also being deprecated.
        const observed = destroy$['observed'] ?? destroy$['observers'].length > 0;
        if (observed) {
            console.warn(createMessage(instance));
        }
    }));
    instance[CheckerHasBeenSet] = true;
}
function isAngularInTestMode() {
    // Gets whether the code is currently running in a test environment.
    // We don't use `declare const` because it might cause conflicts with the real typings.
    return (
    // eslint-disable-next-line @typescript-eslint/ban-ts-comment
    // @ts-ignore
    (typeof __karma__ !== 'undefined' && !!__karma__) ||
        // eslint-disable-next-line @typescript-eslint/ban-ts-comment
        // @ts-ignore
        (typeof jasmine !== 'undefined' && !!jasmine) ||
        // eslint-disable-next-line @typescript-eslint/ban-ts-comment
        // @ts-ignore
        (typeof jest !== 'undefined' && !!jest) ||
        // eslint-disable-next-line @typescript-eslint/ban-ts-comment
        // @ts-ignore
        (typeof Mocha !== 'undefined' && !!Mocha) ||
        // Jest is not defined in ESM mode since it must be access only by importing from `@jest/globals`.
        // There's no way to check if we're in Jest ESM mode or not, but we can check if the `process` is defined.
        // Note: it's required to check for `[object process]` because someone might be running unit tests with
        // Webpack and shimming `process`.
        (typeof process !== 'undefined' &&
            Object.prototype.toString.call(process) === '[object process]'));
}
function runOutsideAngular(fn) {
    // We cannot inject the `NgZone` class when running the checker. The `__ngContext__` is read
    // for the first time within a microtask which triggers change detection; we want to avoid that.
    // The `Zone` is always available globally when the `zone.js` is imported. Otherwise, it may be
    // nooped through bootstrap options. The `NgZone.runOutsideAngular` calls `Zone.root.run`, so we're
    // safe calling that function directly.
    const Zone = ɵglobal.Zone;
    const isNgZoneEnabled = !!Zone && typeof Zone.root?.run === 'function';
    return isNgZoneEnabled ? Zone.root.run(fn) : fn();
}
function createMessage(instance) {
    return `
  The ${instance.constructor.name} still has subscriptions that haven't been unsubscribed.
  This may happen if the class extends another class decorated with @UntilDestroy().
  The child class implements its own ngOnDestroy() method but doesn't call super.ngOnDestroy().
  Let's look at the following example:
  @UntilDestroy()
  @Directive()
  export abstract class BaseDirective {}
  @Component({ template: '' })
  export class ConcreteComponent extends BaseDirective implements OnDestroy {
    constructor() {
      super();
      someObservable$.pipe(untilDestroyed(this)).subscribe();
    }
    ngOnDestroy(): void {
      // Some logic here...
    }
  }
  The BaseDirective.ngOnDestroy() will not be called since Angular will call ngOnDestroy()
  on the ConcreteComponent, but not on the BaseDirective.
  One of the solutions is to declare an empty ngOnDestroy method on the BaseDirective:
  @UntilDestroy()
  @Directive()
  export abstract class BaseDirective {
    ngOnDestroy(): void {}
  }
  @Component({ template: '' })
  export class ConcreteComponent extends BaseDirective implements OnDestroy {
    constructor() {
      super();
      someObservable$.pipe(untilDestroyed(this)).subscribe();
    }
    ngOnDestroy(): void {
      // Some logic here...
      super.ngOnDestroy();
    }
  }
  `;
}
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiY2hlY2tlci5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uLy4uL2xpYnMvdW50aWwtZGVzdHJveS9zcmMvbGliL2NoZWNrZXIudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUEsT0FBTyxFQUFFLE9BQU8sRUFBRSxZQUFZLEVBQWEsTUFBTSxlQUFlLENBQUM7QUFDakUsT0FBTyxFQUFFLEtBQUssRUFBRSxJQUFJLEVBQUUsT0FBTyxFQUFFLE1BQU0sTUFBTSxDQUFDO0FBQzVDLE9BQU8sRUFBRSxRQUFRLEVBQUUsTUFBTSxnQkFBZ0IsQ0FBQztBQUUxQyw0RUFBNEU7QUFDNUUsMkVBQTJFO0FBQzNFLDBFQUEwRTtBQUMxRSxNQUFNLE9BQU8sR0FBRyxDQUFDLENBQUM7QUFFbEIsTUFBTSxpQkFBaUIsR0FBRyxNQUFNLENBQUMsbUJBQW1CLENBQUMsQ0FBQztBQUV0RCxNQUFNLFVBQVUsK0JBQStCLENBQUMsUUFBYSxFQUFFLFFBQXVCO0lBQ3BGLHdGQUF3RjtJQUN4Riw2R0FBNkc7SUFDN0csMkZBQTJGO0lBQzNGLG1EQUFtRDtJQUVuRCxJQUFJLFFBQVEsQ0FBQyxpQkFBaUIsQ0FBQyxJQUFJLG1CQUFtQixFQUFFLEVBQUU7UUFDeEQsT0FBTztLQUNSO0lBRUQsaUJBQWlCLENBQUMsR0FBRyxFQUFFLENBQ3JCLElBQUksQ0FBQyxPQUFPLENBQUMsT0FBTyxFQUFFLENBQUM7U0FDcEIsSUFBSSxDQUNILFFBQVEsQ0FBQyxHQUFHLEVBQUU7UUFDWixJQUFJLFFBQTBCLENBQUM7UUFFL0IsSUFBSTtZQUNGLDhGQUE4RjtZQUM5RixrREFBa0Q7WUFDbEQsUUFBUSxHQUFHLFlBQVksQ0FBQyxRQUFRLENBQUMsQ0FBQztTQUNuQztRQUFDLE1BQU07WUFDTixRQUFRLEdBQUcsSUFBSSxDQUFDO1NBQ2pCO1FBRUQsTUFBTSxLQUFLLEdBQUcsUUFBUSxFQUFFLEtBQUssQ0FBQztRQUU5QixJQUFJLEtBQUssSUFBSSxJQUFJLEVBQUU7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QyxJQUFJOzs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7R0FvQzlCLENBQUM7QUFDSixDQUFDIiwic291cmNlc0NvbnRlbnQiOlsiaW1wb3J0IHsgybVnbG9iYWwsIMm1Z2V0TENvbnRleHQsIMm1TENvbnRleHQgfSBmcm9tICdAYW5ndWxhci9jb3JlJztcbmltcG9ydCB7IEVNUFRZLCBmcm9tLCBTdWJqZWN0IH0gZnJvbSAncnhqcyc7XG5pbXBvcnQgeyBtZXJnZU1hcCB9IGZyb20gJ3J4anMvb3BlcmF0b3JzJztcblxuLy8gYExWaWV3YCBpcyBhbiBhcnJheSB3aGVyZSBlYWNoIGluZGV4IG1hdGNoZXMgdGhlIHNwZWNpZmljIGRhdGEgc3RydWN0dXJlLlxuLy8gVGhlIDd0aCBlbGVtZW50IGluIGFuIGBMVmlld2AgaXMgYW4gYXJyYXkgb2YgY2xlYW51cCBsaXN0ZW5lcnMuIFRoZXkgYXJlXG4vLyBpbnZva2VkIHdoZW4gdGhlIHZpZXcgaXMgcmVtb3ZlZCAoc2ltaWxhciB0byBgQ29tcG9uZW50UmVmLm9uRGVzdHJveWApLlxuY29uc3QgQ0xFQU5VUCA9IDc7XG5cbmNvbnN0IENoZWNrZXJIYXNCZWVuU2V0ID0gU3ltYm9sKCdDaGVja2VySGFzQmVlblNldCcpO1xuXG5leHBvcnQgZnVuY3Rpb24gc2V0dXBTdWJqZWN0VW5zdWJzY3JpYmVkQ2hlY2tlcihpbnN0YW5jZTogYW55LCBkZXN0cm95JDogU3ViamVjdDx2b2lkPik6IHZvaWQge1xuICAvLyBUaGlzIGZ1bmN0aW9uIGlzIHVzZWQgd2l0aGluIHRoZSBgdW50aWxEZXN0cm95ZWRgIG9wZXJhdG9yIGFuZCBzZXR1cHMgYSBmdW5jdGlvbiB0aGF0XG4gIC8vIGxpc3RlbnMgZm9yIHRoZSB2aWV3IHJlbW92YWwgYW5kIGNoZWNrcyBpZiB0aGUgYGRlc3Ryb3kkYCBzdWJqZWN0IGhhcyBhbnkgb2JzZXJ2ZXJzICh1c3VhbGx5IGB0YWtlVW50aWxgKS5cbiAgLy8gTm90ZTogdGhpcyBjb2RlIHdpbGwgbm90IGJlIHNoaXBwZWQgaW50byBwcm9kdWN0aW9uIHNpbmNlIGl0J3MgZ3VhcmRlZCB3aXRoIGBuZ0Rldk1vZGVgLFxuICAvLyB0aGlzIG1lYW5zIGl0J2xsIGV4aXN0IG9ubHkgaW4gZGV2ZWxvcG1lbnQgbW9kZS5cblxuICBpZiAoaW5zdGFuY2VbQ2hlY2tlckhhc0JlZW5TZXRdIHx8IGlzQW5ndWxhckluVGVzdE1vZGUoKSkge1xuICAgIHJldHVybjtcbiAgfVxuXG4gIHJ1bk91dHNpZGVBbmd1bGFyKCgpID0+XG4gICAgZnJvbShQcm9taXNlLnJlc29sdmUoKSlcbiAgICAgIC5waXBlKFxuICAgICAgICBtZXJnZU1hcCgoKSA9PiB7XG4gICAgICAgICAgbGV0IGxDb250ZXh0OiDJtUxDb250ZXh0IHwgbnVsbDtcblxuICAgICAgICAgIHRyeSB7XG4gICAgICAgICAgICAvLyBUaGUgYMm1Z2V0TENvbnRleHRgIG1pZ2h0IG5vdCB3b3JrIGZvciBhIHBpcGUsIGJlY2F1c2UgaXQncyBub3QgYSBjb21wb25lbnQgbm9yIGEgZGlyZWN0aXZlLFxuICAgICAgICAgICAgLy8gd2hpY2ggbWVhbnMgdGhlcmUncyBubyBgUk5vZGVgIGZvciBhbiBpbnN0YW5jZS5cbiAgICAgICAgICAgIGxDb250ZXh0ID0gybVnZXRMQ29udGV4dChpbnN0YW5jZSk7XG4gICAgICAgICAgfSBjYXRjaCB7XG4gICAgICAgICAgICBsQ29udGV4dCA9IG51bGw7XG4gICAgICAgICAgfVxuXG4gICAgICAgICAgY29uc3QgbFZpZXcgPSBsQ29udGV4dD8ubFZpZXc7XG5cbiAgICAgICAgICBpZiAobFZpZXcgPT0gbnVsbCkge1xuICAgICAgICAgICAgcmV0dXJuIEVNUFRZO1xuICAgICAgICAgIH1cblxuICAgICAgICAgIGNvbnN0IGxDbGVhbnVwID0gbFZpZXdbQ0xFQU5VUF0gfHwgKGxWaWV3W0NMRUFOVVBdID0gW10pO1xuICAgICAgICAgIGNvbnN0IGNsZWFudXBIYXNCZWVuRXhlY3V0ZWQkID0gbmV3IFN1YmplY3Q8dm9pZD4oKTtcbiAgICAgICAgICAvLyBOb3RlOiB0aGlzIGZ1bmN0aW9uIGlzIG5hbWVkIGZvciBkZWJ1Z2dpbmcgcHVycG9zZXMuXG4gICAgICAgICAgbENsZWFudXAucHVzaChmdW5jdGlvbiB1bnRpbERlc3Ryb3llZExDbGVhbnVwKCkge1xuICAgICAgICAgICAgLy8gV2UgbGVhdmUgdGhlIEFuZ3VsYXIgem9uZSwgc28gUnhKUyB3aWxsIGFsc28gY2FsbCBzdWJzZXF1ZW50IGBuZXh0YCBmdW5jdGlvbnNcbiAgICAgICAgICAgIC8vIG91dHNpZGUgb2YgdGhlIEFuZ3VsYXIgem9uZSwgd2hpY2ggaXMgZG9uZSB0byBhdm9pZCBzY2hlZHVsaW5nIGEgbWljcm90YXNrICh0aHJvdWdoXG4gICAgICAgICAgICAvLyBgYXNhcFNjaGVkdWxlcmApIHdpdGhpbiB0aGUgQW5ndWxhciB6b25lLlxuICAgICAgICAgICAgcnVuT3V0c2lkZUFuZ3VsYXIoKCkgPT4ge1xuICAgICAgICAgICAgICBjbGVhbnVwSGFzQmVlbkV4ZWN1dGVkJC5uZXh0KCk7XG4gICAgICAgICAgICAgIGNsZWFudXBIYXNCZWVuRXhlY3V0ZWQkLmNvbXBsZXRlKCk7XG4gICAgICAgICAgICB9KTtcbiAgICAgICAgICB9KTtcbiAgICAgICAgICByZXR1cm4gY2xlYW51cEhhc0JlZW5FeGVjdXRlZCQ7XG4gICAgICAgIH0pLFxuICAgICAgICAvLyBXZSBjYW4ndCB1c2UgYG9ic2VydmVPbihhc2FwU2NoZWR1bGVyKWAgYmVjYXVzZSB0aGlzIG1pZ2h0IGJyZWFrIHRoZSBhcHAncyBjaGFuZ2UgZGV0ZWN0aW9uLlxuICAgICAgICAvLyBSeEpTIHNjaGVkdWxlcnMgY29hbGVzY2UgdGFza3MgYW5kIHRoZW4gZmx1c2ggdGhlIHF1ZXVlLCB3aGljaCBtZWFucyBvdXIgdGFzayBtaWdodCBiZSBzY2hlZHVsZWRcbiAgICAgICAgLy8gd2l0aGluIHRoZSByb290IHpvbmUsIGFuZCB0aGVuIGFsbCBvZiB0aGUgdGFza3MgKHRoYXQgd2VyZSBzZXQgdXAgYnkgZGV2ZWxvcGVycyBpbiB0aGUgQW5ndWxhciB6b25lKVxuICAgICAgICAvLyB3aWxsIGFsc28gYmUgZmx1c2hlZCBpbiB0aGUgcm9vdCB6b25lLlxuICAgICAgICBtZXJnZU1hcCgoKSA9PiBQcm9taXNlLnJlc29sdmUoKSlcbiAgICAgIClcbiAgICAgIC5zdWJzY3JpYmUoKCkgPT4ge1xuICAgICAgICAvLyBOb3RlOiBUaGUgYG9ic2VydmVkYCBwcm9wZXJ0eSBpcyBhdmFpbGFibGUgb25seSBpbiBSeEpTQDcuMi4wLCB3aGljaCB3aWxsIHRocm93XG4gICAgICAgIC8vIGFuIGVycm9yIGluIGxvd2VyIHZlcnNpb25zLiBXZSBoYXZlIGludGVncmF0aW9uIHRlc3Qgd2l0aCBSeEpTQDYgdG8gZW5zdXJlIHdlIGRvbid0XG4gICAgICAgIC8vIGltcG9ydCBvcGVyYXRvcnMgZnJvbSBgcnhqc2A7IHRoYXQncyB3aHkgaXQncyB3cmFwcGVkIGludG8gYnJhY2VzLiBUaGUgYG9ic2VydmVyc2BcbiAgICAgICAgLy8gcHJvcGVydHkgaXMgYWxzbyBiZWluZyBkZXByZWNhdGVkLlxuICAgICAgICBjb25zdCBvYnNlcnZlZCA9IGRlc3Ryb3kkWydvYnNlcnZlZCddID8/IGRlc3Ryb3kkWydvYnNlcnZlcnMnXS5sZW5ndGggPiAwO1xuICAgICAgICBpZiAob2JzZXJ2ZWQpIHtcbiAgICAgICAgICBjb25zb2xlLndhcm4oY3JlYXRlTWVzc2FnZShpbnN0YW5jZSkpO1xuICAgICAgICB9XG4gICAgICB9KVxuICApO1xuXG4gIGluc3RhbmNlW0NoZWNrZXJIYXNCZWVuU2V0XSA9IHRydWU7XG59XG5cbmZ1bmN0aW9uIGlzQW5ndWxhckluVGVzdE1vZGUoKTogYm9vbGVhbiB7XG4gIC8vIEdldHMgd2hldGhlciB0aGUgY29kZSBpcyBjdXJyZW50bHkgcnVubmluZyBpbiBhIHRlc3QgZW52aXJvbm1lbnQuXG4gIC8vIFdlIGRvbid0IHVzZSBgZGVjbGFyZSBjb25zdGAgYmVjYXVzZSBpdCBtaWdodCBjYXVzZSBjb25mbGljdHMgd2l0aCB0aGUgcmVhbCB0eXBpbmdzLlxuICByZXR1cm4gKFxuICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBAdHlwZXNjcmlwdC1lc2xpbnQvYmFuLXRzLWNvbW1lbnRcbiAgICAvLyBAdHMtaWdub3JlXG4gICAgKHR5cGVvZiBfX2thcm1hX18gIT09ICd1bmRlZmluZWQnICYmICEhX19rYXJtYV9fKSB8fFxuICAgIC8vIGVzbGludC1kaXNhYmxlLW5leHQtbGluZSBAdHlwZXNjcmlwdC1lc2xpbnQvYmFuLXRzLWNvbW1lbnRcbiAgICAvLyBAdHMtaWdub3JlXG4gICAgKHR5cGVvZiBqYXNtaW5lICE9PSAndW5kZWZpbmVkJyAmJiAhIWphc21pbmUpIHx8XG4gICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIEB0eXBlc2NyaXB0LWVzbGludC9iYW4tdHMtY29tbWVudFxuICAgIC8vIEB0cy1pZ25vcmVcbiAgICAodHlwZW9mIGplc3QgIT09ICd1bmRlZmluZWQnICYmICEhamVzdCkgfHxcbiAgICAvLyBlc2xpbnQtZGlzYWJsZS1uZXh0LWxpbmUgQHR5cGVzY3JpcHQtZXNsaW50L2Jhbi10cy1jb21tZW50XG4gICAgLy8gQHRzLWlnbm9yZVxuICAgICh0eXBlb2YgTW9jaGEgIT09ICd1bmRlZmluZWQnICYmICEhTW9jaGEpIHx8XG4gICAgLy8gSmVzdCBpcyBub3QgZGVmaW5lZCBpbiBFU00gbW9kZSBzaW5jZSBpdCBtdXN0IGJlIGFjY2VzcyBvbmx5IGJ5IGltcG9ydGluZyBmcm9tIGBAamVzdC9nbG9iYWxzYC5cbiAgICAvLyBUaGVyZSdzIG5vIHdheSB0byBjaGVjayBpZiB3ZSdyZSBpbiBKZXN0IEVTTSBtb2RlIG9yIG5vdCwgYnV0IHdlIGNhbiBjaGVjayBpZiB0aGUgYHByb2Nlc3NgIGlzIGRlZmluZWQuXG4gICAgLy8gTm90ZTogaXQncyByZXF1aXJlZCB0byBjaGVjayBmb3IgYFtvYmplY3QgcHJvY2Vzc11gIGJlY2F1c2Ugc29tZW9uZSBtaWdodCBiZSBydW5uaW5nIHVuaXQgdGVzdHMgd2l0aFxuICAgIC8vIFdlYnBhY2sgYW5kIHNoaW1taW5nIGBwcm9jZXNzYC5cbiAgICAodHlwZW9mIHByb2Nlc3MgIT09ICd1bmRlZmluZWQnICYmXG4gICAgICBPYmplY3QucHJvdG90eXBlLnRvU3RyaW5nLmNhbGwocHJvY2VzcykgPT09ICdbb2JqZWN0IHByb2Nlc3NdJylcbiAgKTtcbn1cblxuZnVuY3Rpb24gcnVuT3V0c2lkZUFuZ3VsYXI8VD4oZm46ICgpID0+IFQpOiBUIHtcbiAgLy8gV2UgY2Fubm90IGluamVjdCB0aGUgYE5nWm9uZWAgY2xhc3Mgd2hlbiBydW5uaW5nIHRoZSBjaGVja2VyLiBUaGUgYF9fbmdDb250ZXh0X19gIGlzIHJlYWRcbiAgLy8gZm9yIHRoZSBmaXJzdCB0aW1lIHdpdGhpbiBhIG1pY3JvdGFzayB3aGljaCB0cmlnZ2VycyBjaGFuZ2UgZGV0ZWN0aW9uOyB3ZSB3YW50IHRvIGF2b2lkIHRoYXQuXG4gIC8vIFRoZSBgWm9uZWAgaXMgYWx3YXlzIGF2YWlsYWJsZSBnbG9iYWxseSB3aGVuIHRoZSBgem9uZS5qc2AgaXMgaW1wb3J0ZWQuIE90aGVyd2lzZSwgaXQgbWF5IGJlXG4gIC8vIG5vb3BlZCB0aHJvdWdoIGJvb3RzdHJhcCBvcHRpb25zLiBUaGUgYE5nWm9uZS5ydW5PdXRzaWRlQW5ndWxhcmAgY2FsbHMgYFpvbmUucm9vdC5ydW5gLCBzbyB3ZSdyZVxuICAvLyBzYWZlIGNhbGxpbmcgdGhhdCBmdW5jdGlvbiBkaXJlY3RseS5cbiAgY29uc3QgWm9uZSA9IMm1Z2xvYmFsLlpvbmU7XG4gIGNvbnN0IGlzTmdab25lRW5hYmxlZCA9ICEhWm9uZSAmJiB0eXBlb2YgWm9uZS5yb290Py5ydW4gPT09ICdmdW5jdGlvbic7XG4gIHJldHVybiBpc05nWm9uZUVuYWJsZWQgPyBab25lLnJvb3QucnVuKGZuKSA6IGZuKCk7XG59XG5cbmZ1bmN0aW9uIGNyZWF0ZU1lc3NhZ2UoaW5zdGFuY2U6IGFueSk6IHN0cmluZyB7XG4gIHJldHVybiBgXG4gIFRoZSAke2luc3RhbmNlLmNvbnN0cnVjdG9yLm5hbWV9IHN0aWxsIGhhcyBzdWJzY3JpcHRpb25zIHRoYXQgaGF2ZW4ndCBiZWVuIHVuc3Vic2NyaWJlZC5cbiAgVGhpcyBtYXkgaGFwcGVuIGlmIHRoZSBjbGFzcyBleHRlbmRzIGFub3RoZXIgY2xhc3MgZGVjb3JhdGVkIHdpdGggQFVudGlsRGVzdHJveSgpLlxuICBUaGUgY2hpbGQgY2xhc3MgaW1wbGVtZW50cyBpdHMgb3duIG5nT25EZXN0cm95KCkgbWV0aG9kIGJ1dCBkb2Vzbid0IGNhbGwgc3VwZXIubmdPbkRlc3Ryb3koKS5cbiAgTGV0J3MgbG9vayBhdCB0aGUgZm9sbG93aW5nIGV4YW1wbGU6XG4gIEBVbnRpbERlc3Ryb3koKVxuICBARGlyZWN0aXZlKClcbiAgZXhwb3J0IGFic3RyYWN0IGNsYXNzIEJhc2VEaXJlY3RpdmUge31cbiAgQENvbXBvbmVudCh7IHRlbXBsYXRlOiAnJyB9KVxuICBleHBvcnQgY2xhc3MgQ29uY3JldGVDb21wb25lbnQgZXh0ZW5kcyBCYXNlRGlyZWN0aXZlIGltcGxlbWVudHMgT25EZXN0cm95IHtcbiAgICBjb25zdHJ1Y3RvcigpIHtcbiAgICAgIHN1cGVyKCk7XG4gICAgICBzb21lT2JzZXJ2YWJsZSQucGlwZSh1bnRpbERlc3Ryb3llZCh0aGlzKSkuc3Vic2NyaWJlKCk7XG4gICAgfVxuICAgIG5nT25EZXN0cm95KCk6IHZvaWQge1xuICAgICAgLy8gU29tZSBsb2dpYyBoZXJlLi4uXG4gICAgfVxuICB9XG4gIFRoZSBCYXNlRGlyZWN0aXZlLm5nT25EZXN0cm95KCkgd2lsbCBub3QgYmUgY2FsbGVkIHNpbmNlIEFuZ3VsYXIgd2lsbCBjYWxsIG5nT25EZXN0cm95KClcbiAgb24gdGhlIENvbmNyZXRlQ29tcG9uZW50LCBidXQgbm90IG9uIHRoZSBCYXNlRGlyZWN0aXZlLlxuICBPbmUgb2YgdGhlIHNvbHV0aW9ucyBpcyB0byBkZWNsYXJlIGFuIGVtcHR5IG5nT25EZXN0cm95IG1ldGhvZCBvbiB0aGUgQmFzZURpcmVjdGl2ZTpcbiAgQFVudGlsRGVzdHJveSgpXG4gIEBEaXJlY3RpdmUoKVxuICBleHBvcnQgYWJzdHJhY3QgY2xhc3MgQmFzZURpcmVjdGl2ZSB7XG4gICAgbmdPbkRlc3Ryb3koKTogdm9pZCB7fVxuICB9XG4gIEBDb21wb25lbnQoeyB0ZW1wbGF0ZTogJycgfSlcbiAgZXhwb3J0IGNsYXNzIENvbmNyZXRlQ29tcG9uZW50IGV4dGVuZHMgQmFzZURpcmVjdGl2ZSBpbXBsZW1lbnRzIE9uRGVzdHJveSB7XG4gICAgY29uc3RydWN0b3IoKSB7XG4gICAgICBzdXBlcigpO1xuICAgICAgc29tZU9ic2VydmFibGUkLnBpcGUodW50aWxEZXN0cm95ZWQodGhpcykpLnN1YnNjcmliZSgpO1xuICAgIH1cbiAgICBuZ09uRGVzdHJveSgpOiB2b2lkIHtcbiAgICAgIC8vIFNvbWUgbG9naWMgaGVyZS4uLlxuICAgICAgc3VwZXIubmdPbkRlc3Ryb3koKTtcbiAgICB9XG4gIH1cbiAgYDtcbn1cbiJdfQ==