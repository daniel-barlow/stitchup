# Stitchup

This is a fresh look at an actual problem: how [Updraft](https://github.com/simplybusiness/uPDraFt/) parses its
incoming document creation requests.  Presently this is tackled in a
rather ad-hoc way, in that there are a number of underspecified hashes, 
we signal invalid data by raising exceptions, and we sometimes get 
validation errors in unexpected places.

The approach here is:

* "Parse, don't validate" - everywhere that we check an input is
well-specified, we also convert the external representation into the
object we actually need

* _inspired_ by monads, but is possibly not actually compliant with
the monad laws. (Yes, this is why we have the rather opaque method
names `unit` and `lift`)

The biggest ugliness in this right now is that the Result type might 
hold a hash or an array and you have to know which of them you've been
handed in order to know how to use it, which seems kind of ungainly. 
Look in template.rb to see what I mean

Start by reading [spec/stitchup/template_spec.rb](https://github.com/daniel-barlow/stitchup/blob/main/spec/stitchup/template_spec.rb) to see how it hangs
together


## See also

Some of these links are marked [SB] meaning they are (or, at least,
should be ;-) accessible only to @simplybusiness folk

* https://www.youtube.com/watch?v=J1jYlPtkrqQ

* https://lexi-lambda.github.io/blog/2019/11/05/parse-don-t-validate/

* [SB] https://docs.google.com/presentation/d/1QZV-80THDHnxssK63zmQP7k_FMsUrS9IRDzls0G5jYM/edit#slide=id.g1f87997393_0_782

* [SB] https://drive.google.com/file/d/12GgFci7d2SmfsdSOwMqFumrfYX9j6xC9/view?t=28m20s

* [SB] https://github.com/simplybusiness/uPDraFt/blob/master/lib/updraft/pdf_request.rb
