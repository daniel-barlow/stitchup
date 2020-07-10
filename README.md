# Stitchup

This is a fresh look at an actual problem: how Updraft parses its
incoming document creation requests.  Presently this is tackled in a
rather ad-hoc way, in that there are a number of underspecified hashes
and we sometimes get validation errors in unexpected places.

The approach here is:

* "Parse, don't validate" - everywhere that we check an input is
well-specified, we also convert the external representation into the
object we actually need

* _inspired_ by monads, but is possibly not actually compliant with
the monad laws. (Yes, this is why we have the rather opaque method
names `unit` and `lift`)

The biggest ugliness in this right now is that the Result type only
really accommodates key->value maps, and sometimes we'd like it to
store a value that's just an array. You'll see in Template.parse that
we work around this by faking some field names. This is temporary and
will be addressed once I think of a nice way to do so.

There is also some work that could be done to make the syntax sweeter.

Start by reading [spec/stitchup/template_spec.rb](https://github.com/daniel-barlow/stitchup/blob/main/spec/stitchup/template_spec.rb) to see how it hangs
together


## See also

Some of these links are marked [SB] meaning they are (or, at least,
should be ;-) accessible only to @simplybusiness folk

* https://www.youtube.com/watch?v=J1jYlPtkrqQ

* https://lexi-lambda.github.io/blog/2019/11/05/parse-don-t-validate/

* [SB] https://docs.google.com/presentation/d/1QZV-80THDHnxssK63zmQP7k_FMsUrS9IRDzls0G5jYM/edit#slide=id.g1f87997393_0_782

* [SB] https://drive.google.com/file/d/12GgFci7d2SmfsdSOwMqFumrfYX9j6xC9/view?t=28m20s
