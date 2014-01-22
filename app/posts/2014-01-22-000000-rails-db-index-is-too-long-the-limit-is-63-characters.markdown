---
status: publish
published: true
title: Rails db:migrate error, index is too long
author: Jess Brown
email: jess@brownwebdesign.com
---

The other day I created the following migration:

``` ruby
class CreatePrivateLabelPlanAssignments < ActiveRecord::Migration
  def change
    create_table :private_label_plan_assignments do |t|
      t.belongs_to :private_label_account
      t.belongs_to :plan

      t.timestamps
    end
    add_index :private_label_plan_assignments, :private_label_account_id
    add_index :private_label_plan_assignments, :plan_id
  end
end
```

When I rake the migration `rake db:migrate` I got the following error:

```
-- add_index(:private_label_plan_assignments, :private_label_account_id)
rake aborted!
An error has occurred, this and all later migrations canceled:

Index name
'index_private_label_plan_assignments_on_private_label_account_id' on
table 'private_label_plan_assignments' is too long; the limit is 63
characters/Users/jess/Dropbox/websites/gypsi/gypsi-web/.bundle/gems/ruby/1.9.1/gems/activerecord-3.2.13/lib/active_record/connection_adapters/abstract/schema_statements.rb:573:in
`add_index_options''`
```

I remembered vaguely running into this issue before, but couldn't
remember what the problem was, so I had do to the research all over
again.  Luckily, I found it rather quickly, but I wanted to write it
down somewhere so I could either remember it next time or better
reference it.  Maybe you'll find it helpful too.

The issue is the `add_index` method in rails automatically creates an
index name in the database.  However, the database has it's own limits
and in this case, 63 characters is the limit for an index name.  

The simple solution is to manually name the index and luckily rails
provides that option in the `add_index` method call.  So, just change
your migration to have a manual name like so:

```ruby
class CreatePrivateLabelPlanAssignments < ActiveRecord::Migration
  def change
    create_table :private_label_plan_assignments do |t|
      t.belongs_to :private_label_account
      t.belongs_to :plan

      t.timestamps
    end
    add_index :private_label_plan_assignments, :private_label_account_id, name: "private_label_id"
    add_index :private_label_plan_assignments, :plan_id, name: "plan_id"
  end
end
```

Hope this helps!
