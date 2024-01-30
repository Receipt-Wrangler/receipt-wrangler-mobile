const commonjsGlobal = typeof globalThis !== 'undefined'
    ? globalThis
    : typeof window !== 'undefined'
        ? window
        : typeof global !== 'undefined'
            ? global
            : typeof self !== 'undefined'
                ? self
                : {};
(function () {
    if (!commonjsGlobal.KeyboardEvent) {
        // eslint-disable-next-line @typescript-eslint/no-empty-function
        commonjsGlobal.KeyboardEvent = function (_eventType, _init) { };
    }
})();
export {};
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiY3VzdG9tLWtleWJvYXJkLWV2ZW50LmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vcHJvamVjdHMvbmd4LW1hc2stbGliL3NyYy9saWIvY3VzdG9tLWtleWJvYXJkLWV2ZW50LnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUdBLE1BQU0sY0FBYyxHQUNoQixPQUFPLFVBQVUsS0FBSyxXQUFXO0lBQzdCLENBQUMsQ0FBQyxVQUFVO0lBQ1osQ0FBQyxDQUFDLE9BQU8sTUFBTSxLQUFLLFdBQVc7UUFDL0IsQ0FBQyxDQUFDLE1BQU07UUFDUixDQUFDLENBQUMsT0FBTyxNQUFNLEtBQUssV0FBVztZQUMvQixDQUFDLENBQUMsTUFBTTtZQUNSLENBQUMsQ0FBQyxPQUFPLElBQUksS0FBSyxXQUFXO2dCQUM3QixDQUFDLENBQUMsSUFBSTtnQkFDTixDQUFDLENBQUMsRUFBRSxDQUFDO0FBRWIsQ0FBQztJQUNHLElBQUksQ0FBQyxjQUFjLENBQUMsYUFBYSxFQUFFO1FBQy9CLGdFQUFnRTtRQUNoRSxjQUFjLENBQUMsYUFBYSxHQUFHLFVBQVUsVUFBZSxFQUFFLEtBQVUsSUFBRyxDQUFDLENBQUM7S0FDNUU7QUFDTCxDQUFDLENBQUMsRUFBRSxDQUFDIiwic291cmNlc0NvbnRlbnQiOlsiLyogZXNsaW50LWRpc2FibGUgQHR5cGVzY3JpcHQtZXNsaW50L25vLWV4cGxpY2l0LWFueSAqL1xuZGVjbGFyZSBsZXQgZ2xvYmFsOiBhbnk7XG5cbmNvbnN0IGNvbW1vbmpzR2xvYmFsID1cbiAgICB0eXBlb2YgZ2xvYmFsVGhpcyAhPT0gJ3VuZGVmaW5lZCdcbiAgICAgICAgPyBnbG9iYWxUaGlzXG4gICAgICAgIDogdHlwZW9mIHdpbmRvdyAhPT0gJ3VuZGVmaW5lZCdcbiAgICAgICAgPyB3aW5kb3dcbiAgICAgICAgOiB0eXBlb2YgZ2xvYmFsICE9PSAndW5kZWZpbmVkJ1xuICAgICAgICA/IGdsb2JhbFxuICAgICAgICA6IHR5cGVvZiBzZWxmICE9PSAndW5kZWZpbmVkJ1xuICAgICAgICA/IHNlbGZcbiAgICAgICAgOiB7fTtcblxuKGZ1bmN0aW9uICgpIHtcbiAgICBpZiAoIWNvbW1vbmpzR2xvYmFsLktleWJvYXJkRXZlbnQpIHtcbiAgICAgICAgLy8gZXNsaW50LWRpc2FibGUtbmV4dC1saW5lIEB0eXBlc2NyaXB0LWVzbGludC9uby1lbXB0eS1mdW5jdGlvblxuICAgICAgICBjb21tb25qc0dsb2JhbC5LZXlib2FyZEV2ZW50ID0gZnVuY3Rpb24gKF9ldmVudFR5cGU6IGFueSwgX2luaXQ6IGFueSkge307XG4gICAgfVxufSkoKTtcblxuZXhwb3J0IHR5cGUgQ3VzdG9tS2V5Ym9hcmRFdmVudCA9IEtleWJvYXJkRXZlbnQ7XG4iXX0=