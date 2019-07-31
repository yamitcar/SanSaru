
class UserMailerPreview < ActionMailer::Preview
  def confirmation_instructions
    user = User.new(name: 'Ali', lastname: 'Cate', email: 'user@example.com.co',
                     password: 'foobar', password_confirmation: 'foobar')
    Devise::Mailer.with(resource: 'a_resource', token: 'token').confirmation_instructions(user, {})
  end
end
