
import Foundation

/// Queues the block for execution in the main queue.
internal func sync_main(block: dispatch_block_t) {
	dispatch_sync(dispatch_get_main_queue(), block)
}

/// Equivalent to @synchronize from Obj-C
internal func mutex_lock<T>(lockObj: AnyObject!, block: ()->T) -> T {
	objc_sync_enter(lockObj)
	let retVal: T = block()
	objc_sync_exit(lockObj)
	return retVal
}

/// Queues the block for execution in the global queue
/// for the User Interactive QOS Class.
internal func async_interactive(block: dispatch_block_t) {
	_async_do(QOS_CLASS_USER_INTERACTIVE, block)
}

/// Queues the block for execution in the global queue
/// for the User Initiated QOS Class.
internal func async_initiated(block: dispatch_block_t) {
	_async_do(QOS_CLASS_USER_INITIATED, block)
}

/// Queues the block for execution in the global queue
/// for the Utility QOS Class.
internal func async_utility(block: dispatch_block_t) {
	_async_do(QOS_CLASS_UTILITY, block)
}

/// Queues the block for execution in the global queue
/// for the Background QOS Class.
internal func async_background(block: dispatch_block_t) {
	_async_do(QOS_CLASS_BACKGROUND, block)
}

private func _async_do(qos: dispatch_qos_class_t, block: dispatch_block_t) {
	dispatch_async(dispatch_get_global_queue(qos, 0), block)
}
