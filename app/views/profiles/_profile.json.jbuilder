json.extract! profile, :id, :name, :lastname, :email, :residence, :first_time, :expectancy, :agile_id, :agile_description, :hobbies, :bring, :proposal, :bio, :agileRelation_id, :gender_id, :size_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)
