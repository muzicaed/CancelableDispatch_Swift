# Cancelable delayed closures in Swift

A Swift port of SebastienThiebaud's dispatch_cancelable_block.
https://github.com/SebastienThiebaud/dispatch_cancelable_block


## Usages
```
let printBlock = CancelableDispatch.delayBlock(3.0, closure: {
  println("I am printed! 😍")
})
let notPrintBlock = CancelableDispatch.delayBlock(3.0, closure: {
  println("But... where did I go? 😢")
})

CancelableDispatch.cancelDelay(block)
```

## Usages, if you prefere hanging closuers
```
let printBlock = CancelableDispatch.delayBlock(3.0) {
  println("I am printed! 😍")
}
let notPrintBlock = CancelableDispatch.delayBlock(3.0) {
  println("But... where did I go? 😢")
}

CancelableDispatch.cancelDelay(block)
```

### Enyoy!