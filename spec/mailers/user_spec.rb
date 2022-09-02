require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe 'instructions' do
    let!(:user) { create(:user) }
    let!(:worker) {user.worker}
    let!(:ticket) {create(:ticket, worker_id: worker.id)}



    context "welcome email" do
      let(:welcome_mail) { UserMailer.with(user: user).welcome_email }

      it 'renders the subject' do
        expect(welcome_mail.subject).to eql('Welcome to My Awesome Site')
      end

      it 'renders the receiver email' do
        expect(welcome_mail.to).to eql([user.email])
      end

      it 'renders the sender email' do
        expect(welcome_mail.from).to eql(['danikfox1616@gmail.com'])
      end

      it 'assigns email' do
        expect(welcome_mail.body.encoded).to match(user.email)
      end

      it 'assigns @url' do
        expect(welcome_mail.body.encoded).to match('http://localhost:3000/users/sign_in')
      end
    end

    context "assigned new task" do
      let(:new_task_mail) { UserMailer.with(user: user, ticket: ticket).assigned_new_task }

      it 'renders the subject' do
        expect(new_task_mail.subject).to eql('You get new ticket')
      end

      it 'renders the receiver email' do
        expect(new_task_mail.to).to eql([user.email])
      end

      it 'renders the sender email' do
        expect(new_task_mail.from).to eql(['danikfox1616@gmail.com'])
      end

      it 'assigns email' do
        expect(new_task_mail.body.encoded).to match(user.email)
      end

      it 'assigns title' do
        expect(new_task_mail.body.encoded).to match(ticket.title)
      end

      it 'assigns description' do
        expect(new_task_mail.body.encoded).to match(ticket.description)
      end

      it 'assigns @url' do
        expect(new_task_mail.body.encoded).to match("http://localhost:3000/tickets/#{ticket.id}")
      end

    end

    context "task changed" do
      let(:task_changed_mail) { UserMailer.with(user: user, editor: user.worker , old_ticket: ticket, new_ticket: ticket).task_changed }

      it 'renders the subject' do
        expect(task_changed_mail.subject).to eql('Your ticket has been changed')
      end

      it 'renders the receiver email' do
        expect(task_changed_mail.to).to eql([user.email])
      end

      it 'renders the sender email' do
        expect(task_changed_mail.from).to eql(['danikfox1616@gmail.com'])
      end

      it 'assigns email' do
        expect(task_changed_mail.body.encoded).to match(user.email)
      end

      it 'assigns new title' do
        expect(task_changed_mail.body.encoded).to match(ticket.title)
      end

      it 'assigns new description' do
        expect(task_changed_mail.body.encoded).to match(ticket.description)
      end

      it 'assigns old title' do
        expect(task_changed_mail.body.encoded).to match(ticket.title_was)
      end

      it 'assigns old description' do
        expect(task_changed_mail.body.encoded).to match(ticket.description_was)
      end

      it 'assigns editor first name' do
        expect(task_changed_mail.body.encoded).to match(user.worker.first_name)
      end

      it 'assigns editor last name' do
        expect(task_changed_mail.body.encoded).to match(user.worker.last_name)
      end

      it 'assigns @url' do
        expect(task_changed_mail.body.encoded).to match("http://localhost:3000/tickets/#{ticket.id}")
      end
    end


    context "ping person" do
      let(:worker) {user.worker}
      let!(:comment) {create(:comment, worker_id: worker.id, ticket_id: ticket.id)}
      let(:ping_person_mail) { UserMailer.with(user: user, comment: comment).ping_person }

      it 'renders the subject' do
        expect(ping_person_mail.subject).to eql("You was mentioned in comment")
      end

      it 'renders the receiver email' do
        expect(ping_person_mail.to).to eql([user.email])
      end

      it 'renders the sender email' do
        expect(ping_person_mail.from).to eql(['danikfox1616@gmail.com'])
      end

      it 'assigns editor last name' do
        expect(ping_person_mail.body.encoded).to match(user.email)
      end

      it 'assigns editor last name' do
        expect(ping_person_mail.body.encoded).to match(comment.ticket.title)
      end

      it 'assigns @url1' do
        expect(ping_person_mail.body.encoded).to match("http://localhost:3000/tickets/#{comment.ticket_id}")
      end

      it 'assigns @url2' do
        expect(ping_person_mail.body.encoded).to match("http://localhost:3000/tickets/#{comment.ticket_id}/comments/#{comment.id}")
      end

    end
  end
end
