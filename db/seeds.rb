# frozen_string_literal: false

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# This will create plans in your Stripe account. Check that you don't have duplicates
# or comment out/remove if you want to manage plans manually.
# https://stripe.com/docs/api#plan_object
if !Rails.env.test?
  plans = Plan.create(
    [
      {
        name: "Basic",
        amount: 900,
        interval: "month",
        associated_role: "basic",
        currency: "usd"
      },
      {
        name: "Pro",
        amount: 1500,
        interval: "month",
        associated_role: "pro",
        currency: "usd"
      }
    ]
  )
  puts "CREATED PLANS #{plans.map(&:name).join(', ')}."
  admin_user = CreateAdminService.call
  puts "CREATED ADMIN USER: #{admin_user.email}."
else
  puts "SKIPPED PLAN AND ADMIN CREATION BECAUSE WE'RE IN TEST."
end
