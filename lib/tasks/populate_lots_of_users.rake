# lib/tasks/populate_lots_of_users.rake

require 'faker'

namespace :db do
  desc "Populate the users table with 1,000,000 users"
  task populate_lots_of_users: :environment do
    batch_size = 1000
    num_users = 1_000_000

    puts "Starting to generate #{num_users} users..."
    puts "Going to insert #{num_users / batch_size} batches of #{batch_size} users each."
    puts "This may take a while!"

    number = 0

    num_users.times.each_slice(batch_size) do |batch|
      number += 1
      users = batch.map do
        if rand(2) == 0
          # Confirmed user
          {
            id: SecureRandom.uuid,
            email: Faker::Internet.unique.email,
            username: Faker::Internet.unique.username(specifier: 5..8),
            password_digest: Faker::Internet.password(min_length: 10),
            confirmation_token: nil,
            confirmation_sent_at: nil,
            confirmed_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
          }
        else
          # Unconfirmed user
          {
            id: SecureRandom.uuid,
            email: Faker::Internet.unique.email,
            username: Faker::Internet.unique.username(specifier: 5..8),
            password_digest: Faker::Internet.password(min_length: 10),
            confirmation_token: SecureRandom.uuid,
            confirmation_sent_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
            confirmed_at: nil
          }
        end
      end

      User.insert_all(users)
      puts "Inserted batch of #{batch_size} users (batch #{number} of #{num_users / batch_size}) -- progress: #{(number.to_f / (num_users / batch_size) * 100).round(2)}%"
    end

    puts "Finished generating users."
  end
end
