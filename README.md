# AsyncUtils.swift
Sometimes GCD just isn't terse enough.

Great for times when you need to do something like this...

```swift
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
        objc_sync_enter(self)
        let success = self.long_complex_task()
        objc_sync_exit(self)
        dispatch_sync(dispatch_get_main_queue()) {
            self.task_completed(success)
        }
    }
```

...without writing a novel.

```swift
async_initiated {
    let success = mutex_lock(self) {
        self.long_complex_task()
    }
    sync_main {
        self.task_completed(success)
    }
}
```

## Functions

```swift
func sync_main(block: dispatch_block_t)
```   
Queues the block for execution in the main queue.

```swift
func mutex_lock<T>(lockObj: AnyObject!, block: ()->T) -> T
```
Equivalent to @synchronize from Obj-C.

```swift
func async_interactive(block: dispatch_block_t)
```
Queues the block for execution in the global queue for the User Interactive QOS Class.

```swift
func async_initiated(block: dispatch_block_t)
```
Queues the block for execution in the global queue for the User Initiated QOS Class.

```swift
func async_utility(block: dispatch_block_t)
```
Queues the block for execution in the global que
ue for the Utility QOS Class.

```swift
func async_background(block: dispatch_block_t)
```
Queues the block for execution in the global queue for the Background QOS Class.
