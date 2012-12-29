Service Mocking Example
=======================

Simplistic example on a nice pattern for using webmock and an API stub to test an application that consumes that service.

* `numbers_service_stub.rb`: A stub for a remote service that our application consumes.
* `app.rb`: Our application. It makes calls out to a remote numbers service.
* `app_test.rb`: Tests for our application. It leverages our service stub, and mutates it as necessary to test edge cases.

Run it!

``` ruby
bundle install
ruby app_test.rb
```
