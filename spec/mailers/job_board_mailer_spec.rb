require "spec_helper"

describe JobBoardMailer do
  describe 'confirmation' do
  	let(:jobpost) { mock_model(Job, jobtitle: 'Ruby / Rails Developer', confirmation_email: 'jeanclaudetteambait@gmail.com') }
  	let(:mail) { JobBoardMailer.confirmation(jobpost) }

  	it 'renders the subject' do
  		mail.subject.should == 'Confirmation'
  	end

  	it 'render the receiver email' do
  		mail.to.should == [jobpost.confirmation_email]
  	end

  	it 'renders the sender email' do
  		mail.from.should == ['noreply@igda.com']
  	end

  	it 'assigns @jobpost' do
  		mail.body.encoded.should match(jobpost.jobtitle)
  	end

  	#it 'assigns @confirmation_url' do
  	#	mail.body.encoded.should match("http://application_url/#{jobpost.id}/confirmation")
  	#end

  end
end
