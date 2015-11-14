![Mongosteen](https://slate-git-images.s3-us-west-1.amazonaws.com/mongosteen.png)

# Mongosteen


## An easy way to add RESTful actions

Mongosteen is a library that helps to easily add RESTful actions to mongoid models, providing support for search, pagination, scopes, json configuration and history.

Mongosteen is based on [inherited_resources](https://github.com/josevalim/inherited_resources) gem, get yourself familiar with how it works and what you can do with this great tool.


## Installation

1. Add Mongosteen to your Gemfile:

  ```ruby
  gem 'mongosteen'
  ```

2. Create controller for the model (e.g. ```Post```):

  ```ruby
  class PostsController < ApplicationController
    mongosteen
  end
  ```

3. Connect new controller in ```routes.rb```:

  ```ruby
  resources :posts
  ```


## Mongosteen API

### Index

Index supports **search**, **page**, **perPage** and **scope** parameters:

  ```
  /posts.json?search=Mongosteen&perPage=10&page=2&scope=gems
  ```
Check out external gems documentation to see what options they provide:

- **[mongoid_search](https://github.com/mauriciozaffari/mongoid_search)** — search for mongoid models;
- **[kaminari](https://github.com/amatsuda/kaminari)** — generic Rails pagination solution;
- **[has_scope](https://github.com/plataformatec/has_scope)** — easy way to access mongoid model scopes via controller;


### Versions

Get specific resource **version**:

  ```
  /posts/54f4216f4f6c65e414000000.json?version=2
  ```

No how to add history support for mongoid model, check out:

- **[mongoid-history](https://github.com/aq1018/mongoid-history)** — track changes to mongoid document;


### JSON configuration for models

Sometimes there is a need to configure json output for the model, for example to add model method to output or exclude some internal fields. Mongosteen provides an easy and isolated way to do that in model controller using ```json_config``` method:

  ```ruby
  class PostsController < ApplicationController
    mongosteen
    json_config methods: %w(published_at)
  end
  ```

```json_config``` accepts configuration hash and passes it to [as_json](http://apidock.com/rails/ActiveResource/Base/as_json) method while rendering document json.

If you need to define configuration specifically for methods, e.g. index might not need all document fields to make requests lighter, there is an `actions` special key for that:

```ruby
class PostsController < ApplicationController
  mongosteen
  json_config methods: %w(published_at),
              actions: {
                index: { methods: %w(published_at), exclude: %w(body_html) }
              }
end
```

There are four default actions you can use here: `index`, `show`, `create`, `update`. Also you can specify your custom methods defined in controller and connected via routes.

### Permitted Parameters

For rapid prototyping, Mongosteen allows all input parameters for ```create``` and ```update``` methods. This default behaviour can be overriden by using ```permitted_params``` method in controller, e.g:

  ```ruby
  class Admin::PostsController < Admin::BaseController
    mongosteen

    private

      def post_params
        params.require(:post).permit(:title, :body)
      end
  end
  ```


## Mongosteen family

- [Character](https://github.com/slate-studio/chr): Powerful responsive javascript CMS for apps
- [Mongosteen](https://github.com/slate-studio/mongosteen): An easy way to add RESTful actions for Mongoid models
- [Inverter](https://github.com/slate-studio/inverter): An easy way to connect Rails templates content to Character CMS
- [Loft](https://github.com/slate-studio/loft): Media assets manager for Character CMS


## License

Copyright © 2015 [Slate Studio, LLC](http://slatestudio.com). Mongoosteen is free software, and may be redistributed under the terms specified in the [license](LICENSE.md).


## About Slate Studio

[![Slate Studio](https://slate-git-images.s3-us-west-1.amazonaws.com/slate.png)](http://slatestudio.com)

Mongoosteen is maintained and funded by [Slate Studio, LLC](http://slatestudio.com). Tweet your questions or suggestions to [@slatestudio](https://twitter.com/slatestudio) and while you’re at it follow us too.
