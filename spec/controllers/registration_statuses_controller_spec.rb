require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe RegistrationStatusesController do

  # This should return the minimal set of attributes required to create a valid
  # RegistrationStatus. As you add validations to RegistrationStatus, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RegistrationStatusesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all registration_statuses as @registration_statuses" do
      registration_status = RegistrationStatus.create! valid_attributes
      get :index, {}, valid_session
      assigns(:registration_statuses).should eq([registration_status])
    end
  end

  describe "GET show" do
    it "assigns the requested registration_status as @registration_status" do
      registration_status = RegistrationStatus.create! valid_attributes
      get :show, {:id => registration_status.to_param}, valid_session
      assigns(:registration_status).should eq(registration_status)
    end
  end

  describe "GET new" do
    it "assigns a new registration_status as @registration_status" do
      get :new, {}, valid_session
      assigns(:registration_status).should be_a_new(RegistrationStatus)
    end
  end

  describe "GET edit" do
    it "assigns the requested registration_status as @registration_status" do
      registration_status = RegistrationStatus.create! valid_attributes
      get :edit, {:id => registration_status.to_param}, valid_session
      assigns(:registration_status).should eq(registration_status)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new RegistrationStatus" do
        expect {
          post :create, {:registration_status => valid_attributes}, valid_session
        }.to change(RegistrationStatus, :count).by(1)
      end

      it "assigns a newly created registration_status as @registration_status" do
        post :create, {:registration_status => valid_attributes}, valid_session
        assigns(:registration_status).should be_a(RegistrationStatus)
        assigns(:registration_status).should be_persisted
      end

      it "redirects to the created registration_status" do
        post :create, {:registration_status => valid_attributes}, valid_session
        response.should redirect_to(RegistrationStatus.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved registration_status as @registration_status" do
        # Trigger the behavior that occurs when invalid params are submitted
        RegistrationStatus.any_instance.stub(:save).and_return(false)
        post :create, {:registration_status => {}}, valid_session
        assigns(:registration_status).should be_a_new(RegistrationStatus)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        RegistrationStatus.any_instance.stub(:save).and_return(false)
        post :create, {:registration_status => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested registration_status" do
        registration_status = RegistrationStatus.create! valid_attributes
        # Assuming there are no other registration_statuses in the database, this
        # specifies that the RegistrationStatus created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        RegistrationStatus.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => registration_status.to_param, :registration_status => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested registration_status as @registration_status" do
        registration_status = RegistrationStatus.create! valid_attributes
        put :update, {:id => registration_status.to_param, :registration_status => valid_attributes}, valid_session
        assigns(:registration_status).should eq(registration_status)
      end

      it "redirects to the registration_status" do
        registration_status = RegistrationStatus.create! valid_attributes
        put :update, {:id => registration_status.to_param, :registration_status => valid_attributes}, valid_session
        response.should redirect_to(registration_status)
      end
    end

    describe "with invalid params" do
      it "assigns the registration_status as @registration_status" do
        registration_status = RegistrationStatus.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        RegistrationStatus.any_instance.stub(:save).and_return(false)
        put :update, {:id => registration_status.to_param, :registration_status => {}}, valid_session
        assigns(:registration_status).should eq(registration_status)
      end

      it "re-renders the 'edit' template" do
        registration_status = RegistrationStatus.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        RegistrationStatus.any_instance.stub(:save).and_return(false)
        put :update, {:id => registration_status.to_param, :registration_status => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested registration_status" do
      registration_status = RegistrationStatus.create! valid_attributes
      expect {
        delete :destroy, {:id => registration_status.to_param}, valid_session
      }.to change(RegistrationStatus, :count).by(-1)
    end

    it "redirects to the registration_statuses list" do
      registration_status = RegistrationStatus.create! valid_attributes
      delete :destroy, {:id => registration_status.to_param}, valid_session
      response.should redirect_to(registration_statuses_url)
    end
  end

end
