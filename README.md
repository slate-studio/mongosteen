![Mongosteen](https://slate-git-images.s3-us-west-1.amazonaws.com/mongosteen.png)

# Mongosteen

## An easy way to add restful actions

Mongosteen is a library that helps to easily add restful actions to mongoid models and adds support of search, pagination, scopes, json config and history.

Mongosteen is based on [inherited_resources](https://github.com/josevalim/inherited_resources) gem, get yourself familiar on how it works and setup using it's documentation.

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

#### Index

Index supports **search**, **page**, **perPage** and **scope** parameters:

  ```
  /posts.json?search=Mongosteen&perPage=10&page=2&scope=gems
  ```
Check out external gems documentation to see what options they provide:

- **[mongoid_search](https://github.com/mauriciozaffari/mongoid_search)** — search for mongoid models;
- **[kaminari](https://github.com/amatsuda/kaminari)** — generic Rails pagination solution;
- **[has_scope](https://github.com/plataformatec/has_scope)** — easy way to access mongoid model scopes via controller;

#### Versions

Get specific resource **version**:

  ```
  /posts/54f4216f4f6c65e414000000.json?version=2
  ```

No how to add history support for mongoid model, check out:

- **[mongoid-history](https://github.com/aq1018/mongoid-history)** — track changes to mongoid document;

#### JSON config for model

Some times there is a need to configure json output for the model, for example to add model method to output or to exclude some internal fields. Mongosteen provides an easy and isolated way to do that in models controller using ```json_config``` method:

  ```ruby
  class PostsController < ApplicationController
    mongosteen
    json_config({ methods: [ :published_at ] })
  end
  ```

```json_config``` accepts configuration hash and passes it to [as_json](http://apidock.com/rails/ActiveResource/Base/as_json) method when render output.

#### Sorted Relations

In Mongoid, the HABTM relations return docs in the wrong order. This workaround gives your document the ability to retrieve it's relations in the same order it was placed in. This is refactored version of an original [mongoid-sorted-relations](https://github.com/demarque/mongoid-sorted-relations) gem.

For more details about this issue, see [#1548](https://github.com/mongoid/mongoid/issues/1548).

Usage example:

  ```ruby
  class Post
    include Mongoid::Document
    include Mongoid::SortedRelations

    has_and_belongs_to_many :authors
  end

  post = Book.new title: 'Restful actions with Mongosteen'
  post.authors << Author.create name: "Alexander Kravets"
  post.authors << Author.create name: "Roman Brazhnyk"
  post.authors << Author.create name: "Maxim Melnyk"

  post.sorted_authors.map(&:name)
  #=> ['Alexander Kravets', 'Roman Brazhnyk', 'Maxim Melnyk']
  ```

Check out orignal gem [documentation](https://github.com/demarque/mongoid-sorted-relations) for more usage examples.

#### Permitted Parameters

For easiness of prototyping, Mongosteen has a workaround that allows all input parameters for ```create``` and ```update``` methods. This default behaviour can be overriden by using ```permitted_params``` method inside of models controller, e.g.:

  ```ruby
  class Admin::PostsController < Admin::BaseController
    mongosteen

    protected

    def permitted_params
      params.permit(:post => [:title, :body])
    end
  end
  ```

#### Serializable Model Id

By default mongoid model serializes document id into hash, to override that add ```Mongoid::SerializedId``` to model class:

  ```ruby
  class Post
    include Mongoid::Document
    include Mongoid::SortedRelations
    include Mongoid::SerializedId
  end
  ```

## The Mongosteen family

- [Character](https://github.com/slate-studio/chr): A simple and lightweight javascript library for building data management web apps

## Credits

[![Slate Studio](https://slate-git-images.s3-us-west-1.amazonaws.com/slate.png)](http://slatestudio.com)

Mongosteen is maintained and funded by [Slate Studio, LLC](http://slatestudio.com). Tweet your questions or suggestions to [@slatestudio](https://twitter.com/slatestudio) and while you’re at it follow us too.

## License

Copyright © 2015 [Slate Studio, LLC](http://slatestudio.com). Mongosteen is free software, and may be redistributed under the terms specified in the [license](LICENSE.md).