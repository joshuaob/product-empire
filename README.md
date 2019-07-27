# Product Empire - JSON API

Welcome to the Product Empire API. This is a ruby on rails API built according to the JSONAPI spec for the management of Products. The following outline the steps necessary to get the API up and running.

### Prerequisite
This project is built on Ruby (2.5.3), the following gems are required
* bundler - `gem install bundler`

### Starting Up  
In order to get the API running, please perform the following steps
* clone this repo - `git clone https://github.com/joshuaob/product-empire.git`
* change into directory - `cd product_empire`
* install dependencies - `bundle install`
* create databases - `bundle exec rake db:create`
* run migrations - `bundle exec rake db:migrate`
* start rails server - `bundle exec rails s`

### Supported Endpoints
This API supports the following endpoints   
* POST /products - Create a product, it returns a product
* GET /products - Get all products, it returns a collection of products
* GET /products?filter[name]=:name - Filter products by name, it returns first matching product.
* GET /products/:id - Get a single product, it returns a product
* PATCH /products/:id - Update a product, it returns a product
* DELETE /products/:id - Delete a product, it returns nothing

### Running tests  
You may run the test suite with - `bundle exec rspec spec`
