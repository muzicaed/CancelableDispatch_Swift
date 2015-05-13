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

if let block = notPrintBlock {
  block(cancel: true)
}
```

### Enyoy!