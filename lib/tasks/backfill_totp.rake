namespace :user do
  desc "Backfill TOTP fields for existing users"
  task backfill_totp: :environment do
    puts "Found #{User.where(totp_enabled: nil).count} users without TOTP fields."
    puts "Backfilling TOTP fields for existing users... this may take a while!"

    index = 0
    User.where(totp_enabled: nil).find_each do |user|
      user.update(totp_enabled: false, totp_secret: ROTP::Base32.random)
      puts "Backfilled TOTP fields for user #{index + 1} / #{User.where(totp_enabled: nil).count} (#{((index + 1).to_f / User.where(totp_enabled: nil).count * 100).round(2)}%)"
      index += 1
    end
  end
end
