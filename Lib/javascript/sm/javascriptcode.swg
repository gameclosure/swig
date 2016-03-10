/* -----------------------------------------------------------------------------
 * js_ctor:  template for wrapping a ctor.
 *   - $jswrapper:        wrapper of called ctor
 *   - $jslocals:         locals part of wrapper
 *   - $jscode:           code part of wrapper
 *   - $jsargcount:       number of arguments
 *   - $jsmangledtype:    mangled type of class
 * ----------------------------------------------------------------------------- */

// JS::Value -> SwigSMArguments
// JS_NewObjectForConstructor -> SWIG_SM_NewPointerObj
// ClassDefinition -> SWIG_POINTER_OWN
// JS_NewObjectForConstructor - > SWIG_SM_NewPointerObj
// Object -> $jsmangledtype

%fragment("js_ctor", "templates")
%{
static SwigSMReturnValue $jswrapper(JSContext *cx, unsigned argc, JS::Value *vp)
{
    $jslocals
    if(argc != $jsargcount) SWIG_exception_fail(SWIG_ERROR, "Illegal number of arguments for $jswrapper.");

    $jscode

    CallArgs args = CallArgsFromVp(argc, vp);
    RootedObject thiz(cx, JS_NewObjectForConstructor(cx, &SWIG_POINTER_OWN, vp));

    //args.rval().setObject(*thiz);
    SWIGTYPE_$jsmangledtype(*thiz)

    goto fail;
    fail:
    return NULL;
}
%}
