class UserMailer < ActionMailer::Base
  default from: 'lunchpad.us@gmail.com'

  def new_account(account_id)
    @account = Account.find(account_id)
    create_mail(@account.user, 'You have created a new lunchbox.')
  end

  def new_note(note_id)
    @note = Note.find(note_id)
    @problem = @note.problem
    create_mail(@problem.user, 'A note was added to your problem in Homework Helper')
  end

  private

  def create_mail(user, message)
    @user = user
    mail to: @user.email, subject: message
  end
end