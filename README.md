# ABRefactoring

A rough and ready debugging tool to help refactoring / moving logic from one application to another.

## Installation

None required, this is a simple repository ready to be used.

## Usage
### Pasting log data into the project
- paste the log content of your legacy application in logs/a
- paste the log content of your new application in logs/b

#### Turning server logs into fixtures
##### Output resources created in database calls, for application a, as YAML.
`ruby log_parser.rb a`
```bash
---
insert_products:
  provider_id: '173'
  quantity: '7'
  reference: HJIK4
---
update_providers:
  provider_id: '15935967'
  status: live
```

##### Output resources created in database calls, for application a, as Hashes.
`ruby log_parser.rb a hashes`

```ruby
{"provider_id"=>"173", "quantity"=>"7", "reference"=>"HJIK4"}
{"provider_id"=>"15935967", "status"=>"live"}
```

### Create fixture files
- create a yaml file per resource created in the database
- add those the yaml files under the relevant namespace, e.g `fixtures/a` for resources created by application a

### Edit the spec file
- add as many context as resouces created

### Run rspec
- make use of rpsec and its context mechanism to easily isolate potential discrepancies between one resouce created by application a VS application b.

```bash
bundle exec rspec spec/resources_spec.rb -e 'the name of my context describing a resource'
# e.g
bundle exec rspec spec/resources_spec.rb -e 'products'
```

## Example provided
Running the `spec/resources_spec.rb` you will be presented with the following failure.

```bash
     Failure/Error: expect(application_a_object).to eq application_b_object

       expected: {"provider_id"=>"173", "quantity"=>"0"}
            got: {"provider_id"=>"173", "quantity"=>"7", "reference"=>"HJIK4"}

       (compared using ==)

       Diff:
       @@ -1,3 +1,4 @@
        "provider_id" => "173",
       -"quantity" => "0",
       +"quantity" => "7",
       +"reference" => "HJIK4",
```

This illustrates that application b is not currently matching all actions performed by application a.
- quantity has not been set correctly on product
- the reference field has not been processed at all while using application b

## Contributing

Bug reports are welcome on GitHub at https://github.com/joe-at-github/a_b_refactoring.
