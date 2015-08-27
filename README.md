# Rails Runner

Rails Runner is a lightweight Ruby web framework inspired by the functionality of Ruby on Rails. It implements a MVC software pattern using Ruby Metaprogramming, dynamically generated routes, ERB template rendering, and parameter parsing. Written using TDD-style using RSpec.

## Implementation
### Controller
Uses a controller base class for initialization and intercommunication between models and views.
Controllers have access to a params hash, as well as sessions

### Router
* Routes are instantiated in the /bin/server file.
* Router recognizes standard RESTful actions
* Uses regex pattern matching to route requests

### Views
* Uses ERB for views
