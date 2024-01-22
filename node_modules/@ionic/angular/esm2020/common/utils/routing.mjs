/**
 * Provides a way to customize when activated routes get reused.
 */
export class IonicRouteStrategy {
    /**
     * Whether the given route should detach for later reuse.
     */
    shouldDetach(_route) {
        return false;
    }
    /**
     * Returns `false`, meaning the route (and its subtree) is never reattached
     */
    shouldAttach(_route) {
        return false;
    }
    /**
     * A no-op; the route is never stored since this strategy never detaches routes for later re-use.
     */
    store(_route, _detachedTree) {
        return;
    }
    /**
     * Returns `null` because this strategy does not store routes for later re-use.
     */
    retrieve(_route) {
        return null;
    }
    /**
     * Determines if a route should be reused.
     * This strategy returns `true` when the future route config and
     * current route config are identical and all route parameters are identical.
     */
    shouldReuseRoute(future, curr) {
        if (future.routeConfig !== curr.routeConfig) {
            return false;
        }
        // checking router params
        const futureParams = future.params;
        const currentParams = curr.params;
        const keysA = Object.keys(futureParams);
        const keysB = Object.keys(currentParams);
        if (keysA.length !== keysB.length) {
            return false;
        }
        // Test for A's keys different from B.
        for (const key of keysA) {
            if (currentParams[key] !== futureParams[key]) {
                return false;
            }
        }
        return true;
    }
}
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicm91dGluZy5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uL2NvbW1vbi9zcmMvdXRpbHMvcm91dGluZy50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiQUFHQTs7R0FFRztBQUNILE1BQU0sT0FBTyxrQkFBa0I7SUFDN0I7O09BRUc7SUFDSCxZQUFZLENBQUMsTUFBOEI7UUFDekMsT0FBTyxLQUFLLENBQUM7SUFDZixDQUFDO0lBRUQ7O09BRUc7SUFDSCxZQUFZLENBQUMsTUFBOEI7UUFDekMsT0FBTyxLQUFLLENBQUM7SUFDZixDQUFDO0lBRUQ7O09BRUc7SUFDSCxLQUFLLENBQUMsTUFBOEIsRUFBRSxhQUFrQztRQUN0RSxPQUFPO0lBQ1QsQ0FBQztJQUVEOztPQUVHO0lBQ0gsUUFBUSxDQUFDLE1BQThCO1FBQ3JDLE9BQU8sSUFBSSxDQUFDO0lBQ2QsQ0FBQztJQUVEOzs7O09BSUc7SUFDSCxnQkFBZ0IsQ0FBQyxNQUE4QixFQUFFLElBQTRCO1FBQzNFLElBQUksTUFBTSxDQUFDLFdBQVcsS0FBSyxJQUFJLENBQUMsV0FBVyxFQUFFO1lBQzNDLE9BQU8sS0FBSyxDQUFDO1NBQ2Q7UUFFRCx5QkFBeUI7UUFDekIsTUFBTSxZQUFZLEdBQUcsTUFBTSxDQUFDLE1BQU0sQ0FBQztRQUNuQyxNQUFNLGFBQWEsR0FBRyxJQUFJLENBQUMsTUFBTSxDQUFDO1FBQ2xDLE1BQU0sS0FBSyxHQUFHLE1BQU0sQ0FBQyxJQUFJLENBQUMsWUFBWSxDQUFDLENBQUM7UUFDeEMsTUFBTSxLQUFLLEdBQUcsTUFBTSxDQUFDLElBQUksQ0FBQyxhQUFhLENBQUMsQ0FBQztRQUV6QyxJQUFJLEtBQUssQ0FBQyxNQUFNLEtBQUssS0FBSyxDQUFDLE1BQU0sRUFBRTtZQUNqQyxPQUFPLEtBQUssQ0FBQztTQUNkO1FBRUQsc0NBQXNDO1FBQ3RDLEtBQUssTUFBTSxHQUFHLElBQUksS0FBSyxFQUFFO1lBQ3ZCLElBQUksYUFBYSxDQUFDLEdBQUcsQ0FBQyxLQUFLLFlBQVksQ0FBQyxHQUFHLENBQUMsRUFBRTtnQkFDNUMsT0FBTyxLQUFLLENBQUM7YUFDZDtTQUNGO1FBQ0QsT0FBTyxJQUFJLENBQUM7SUFDZCxDQUFDO0NBQ0YiLCJzb3VyY2VzQ29udGVudCI6WyIvKiBlc2xpbnQtZGlzYWJsZSBAdHlwZXNjcmlwdC1lc2xpbnQvbm8tdW51c2VkLXZhcnMgKi9cbmltcG9ydCB7IEFjdGl2YXRlZFJvdXRlU25hcHNob3QsIERldGFjaGVkUm91dGVIYW5kbGUsIFJvdXRlUmV1c2VTdHJhdGVneSB9IGZyb20gJ0Bhbmd1bGFyL3JvdXRlcic7XG5cbi8qKlxuICogUHJvdmlkZXMgYSB3YXkgdG8gY3VzdG9taXplIHdoZW4gYWN0aXZhdGVkIHJvdXRlcyBnZXQgcmV1c2VkLlxuICovXG5leHBvcnQgY2xhc3MgSW9uaWNSb3V0ZVN0cmF0ZWd5IGltcGxlbWVudHMgUm91dGVSZXVzZVN0cmF0ZWd5IHtcbiAgLyoqXG4gICAqIFdoZXRoZXIgdGhlIGdpdmVuIHJvdXRlIHNob3VsZCBkZXRhY2ggZm9yIGxhdGVyIHJldXNlLlxuICAgKi9cbiAgc2hvdWxkRGV0YWNoKF9yb3V0ZTogQWN0aXZhdGVkUm91dGVTbmFwc2hvdCk6IGJvb2xlYW4ge1xuICAgIHJldHVybiBmYWxzZTtcbiAgfVxuXG4gIC8qKlxuICAgKiBSZXR1cm5zIGBmYWxzZWAsIG1lYW5pbmcgdGhlIHJvdXRlIChhbmQgaXRzIHN1YnRyZWUpIGlzIG5ldmVyIHJlYXR0YWNoZWRcbiAgICovXG4gIHNob3VsZEF0dGFjaChfcm91dGU6IEFjdGl2YXRlZFJvdXRlU25hcHNob3QpOiBib29sZWFuIHtcbiAgICByZXR1cm4gZmFsc2U7XG4gIH1cblxuICAvKipcbiAgICogQSBuby1vcDsgdGhlIHJvdXRlIGlzIG5ldmVyIHN0b3JlZCBzaW5jZSB0aGlzIHN0cmF0ZWd5IG5ldmVyIGRldGFjaGVzIHJvdXRlcyBmb3IgbGF0ZXIgcmUtdXNlLlxuICAgKi9cbiAgc3RvcmUoX3JvdXRlOiBBY3RpdmF0ZWRSb3V0ZVNuYXBzaG90LCBfZGV0YWNoZWRUcmVlOiBEZXRhY2hlZFJvdXRlSGFuZGxlKTogdm9pZCB7XG4gICAgcmV0dXJuO1xuICB9XG5cbiAgLyoqXG4gICAqIFJldHVybnMgYG51bGxgIGJlY2F1c2UgdGhpcyBzdHJhdGVneSBkb2VzIG5vdCBzdG9yZSByb3V0ZXMgZm9yIGxhdGVyIHJlLXVzZS5cbiAgICovXG4gIHJldHJpZXZlKF9yb3V0ZTogQWN0aXZhdGVkUm91dGVTbmFwc2hvdCk6IERldGFjaGVkUm91dGVIYW5kbGUgfCBudWxsIHtcbiAgICByZXR1cm4gbnVsbDtcbiAgfVxuXG4gIC8qKlxuICAgKiBEZXRlcm1pbmVzIGlmIGEgcm91dGUgc2hvdWxkIGJlIHJldXNlZC5cbiAgICogVGhpcyBzdHJhdGVneSByZXR1cm5zIGB0cnVlYCB3aGVuIHRoZSBmdXR1cmUgcm91dGUgY29uZmlnIGFuZFxuICAgKiBjdXJyZW50IHJvdXRlIGNvbmZpZyBhcmUgaWRlbnRpY2FsIGFuZCBhbGwgcm91dGUgcGFyYW1ldGVycyBhcmUgaWRlbnRpY2FsLlxuICAgKi9cbiAgc2hvdWxkUmV1c2VSb3V0ZShmdXR1cmU6IEFjdGl2YXRlZFJvdXRlU25hcHNob3QsIGN1cnI6IEFjdGl2YXRlZFJvdXRlU25hcHNob3QpOiBib29sZWFuIHtcbiAgICBpZiAoZnV0dXJlLnJvdXRlQ29uZmlnICE9PSBjdXJyLnJvdXRlQ29uZmlnKSB7XG4gICAgICByZXR1cm4gZmFsc2U7XG4gICAgfVxuXG4gICAgLy8gY2hlY2tpbmcgcm91dGVyIHBhcmFtc1xuICAgIGNvbnN0IGZ1dHVyZVBhcmFtcyA9IGZ1dHVyZS5wYXJhbXM7XG4gICAgY29uc3QgY3VycmVudFBhcmFtcyA9IGN1cnIucGFyYW1zO1xuICAgIGNvbnN0IGtleXNBID0gT2JqZWN0LmtleXMoZnV0dXJlUGFyYW1zKTtcbiAgICBjb25zdCBrZXlzQiA9IE9iamVjdC5rZXlzKGN1cnJlbnRQYXJhbXMpO1xuXG4gICAgaWYgKGtleXNBLmxlbmd0aCAhPT0ga2V5c0IubGVuZ3RoKSB7XG4gICAgICByZXR1cm4gZmFsc2U7XG4gICAgfVxuXG4gICAgLy8gVGVzdCBmb3IgQSdzIGtleXMgZGlmZmVyZW50IGZyb20gQi5cbiAgICBmb3IgKGNvbnN0IGtleSBvZiBrZXlzQSkge1xuICAgICAgaWYgKGN1cnJlbnRQYXJhbXNba2V5XSAhPT0gZnV0dXJlUGFyYW1zW2tleV0pIHtcbiAgICAgICAgcmV0dXJuIGZhbHNlO1xuICAgICAgfVxuICAgIH1cbiAgICByZXR1cm4gdHJ1ZTtcbiAgfVxufVxuIl19