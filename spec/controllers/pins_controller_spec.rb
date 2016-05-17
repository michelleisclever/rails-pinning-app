require 'spec_helper'
RSpec.describe PinsController do
    describe "GET index" do
        
        it 'renders the index template' do
        get :index
        expect(response).to render_template("index")
    end
        
        it 'populates @pins with all pins' do
            get :index
            expect(assigns[:pins]).to eq(Pin.all)
end
        
        describe "GET new" do
    it 'responds with successfully' do
      get :new
      expect(response.success?).to be(true)
    end
    
    it 'renders the new view' do
      get :new      
      expect(response).to render_template(:new)
    end
    
    it 'assigns an instance variable to a new pin' do
      get :new
      expect(assigns(:pin)).to be_a_new(Pin)
    end
  end
  
  describe "POST create" do
    before(:each) do
      @pin_hash = { 
        title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard", 
        text: "A fun and helpful Rails Resource",
          category_id: 2}    
    end
    
    after(:each) do
      pin = Pin.find_by_slug("rails-wizard")
      if !pin.nil?
        pin.destroy
      end
    end
    
    it 'responds with a redirect' do
      post :create, pin: @pin_hash
      expect(response.redirect?).to be(true)
    end
    
    it 'creates a pin' do
      post :create, pin: @pin_hash  
      expect(Pin.find_by_slug("rails-wizard").present?).to be(true)
    end
    
    it 'redirects to the show view' do
      post :create, pin: @pin_hash
      expect(response).to redirect_to(pin_url(assigns(:pin)))
    end
    
    it 'redisplays new form on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash.delete(:title)
      post :create, pin: @pin_hash
      expect(response).to render_template(:new)
    end
    
    it 'assigns the @errors instance variable on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash.delete(:title)
      post :create, pin: @pin_hash
      expect(assigns[:errors].present?).to be(true)
    end    
  end

describe "GET edit" do
    
       before(:each) do
           @pin_test = Pin.first  
    end

# get to pins/id/edit
# responds successfully 
     it 'responds with successfully' do
         get :edit, id: @pin_test
      expect(response.success?).to be(true)
    end
    
# renders the edit template
    
    it 'renders the edit view' do
        get :edit, id: @pin_test   
        expect(response).to render_template(:edit)
    end
    
# assigns an instance variable called @pin to the Pin with the appropriate id
    
    it 'assigns an instance variable called @pin to the Pin' do
        get :edit, id: @pin_test
        expect(assigns(:pin)).to eq(Pin.find(1))
    end
    
    
end

#PUT update test taken from https://github.com/tnataly/coder-pinterest/blob/ccd1232d3783debdc57b536525c0fa82289d4cc7/spec/controllers/pins_controller_spec.rb
  
  describe "PUT update" do  
      before (:all) do
        @pin = Pin.create(title: "Learn RUBY hard way", 
          url: "http://google.com", 
          text: "Some super text",
          slug: "ruby-hard",
          category_id: "ruby") 
    end

    context "request to /pins with valid parameters" do
    let(:attr) do
          { :title => "Learn Rails", 
            :url => "New url",
            :text => "The new text",
            :slug => "ruby-hard"
           }
        end      

    before(:each) do
          put :update, :id => @pin.id, :pin => attr
          @pin.reload
    end

      it 'updates a pin' do
        expect(@pin.title).to eql attr[:title] 
        expect(@pin.url).to eql attr[:url]
        expect(@pin.text).to eql attr[:text]
        expect(@pin.slug).to eql attr[:slug]
        #puts "===================\n" + response.body
     end
    
      it 'redirects to the show view' do
          expect(response).to redirect_to(pin_path(assigns(:pin)))
      end
    end

    context "request to /pins with invalid parameters" do
    let(:attr) do
          { :title => "", 
            :url => "",
            :text => "The new text",
            :slug => "ruby-hard"
           }
        end      



    before(:each) do
          put :update, :id => @pin.id, :pin => attr
          @pin.reload
    end

    it "assigns an @errors instance variable" do
      #puts "===================\n" + response.body
      expect(assigns[:errors].present?).to be(true)
    end

    it "renders the edit view" do
      #puts "===================\n" + response.body
      expect(response).to render_template(:edit)
    end
  end

  end

end
end