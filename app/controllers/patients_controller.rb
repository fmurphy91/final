# Include the patient_decorator for the extra requests MRI, Xray etc..
require 'patient_decorator'
# Include the patient_logger to enable to record some data in a .txt file about patients
require 'patient_logger'
class PatientsController < ApplicationController
  # Authenticate user enables only registered users to access
  before_action :authenticate_user!
  # allows only admin users access the :ensure_admin to allow them to destroy/delete patients
  before_filter :ensure_admin, :only => [:destroy]
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  http_basic_authenticate_with name: "dhh", password: "secret"
  # GET /patients
  # GET /patients.json
  def index
    @patients = Patient.all

    @patients = Patient.order("fullname")

    if params[:search]
      @patients = Patient.search(params[:search])
      @patients = @patients.order("created_at ASC")
    else
      @patients = @patients.order("created_at DESC")
    end

  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    #add appointments to the patients controller where patient_id is patient id ordered descending
    @appointments = Appointment.where(patient_id: @patient.id).order("created_at DESC")
  end

  # GET /patients/new
  def new
    # Create patient from the current_user logged in i.e the current doctor logged in
    @patient = current_user.patients.new
    #@patient = Patient.find(params:patient_id)
    @appointment = Appointment.new
  end

  # GET /patients/1/edit
  def edit
  end

  def ensure_admin
    unless current_user && current_user.admin?
      render :text => "Access Error Message", :status => :unauthorized
    end
  end

  # POST /patients
  # POST /patients.json
  def create
    # Create patient based on current_user
    @patient = current_user.patients.build()
    @patient.fullname = params[:patient][:fullname]
    @patient.birthdate = params[:patient][:birthdate]
    @patient.telephone = params[:patient][:telephone]
    @patient.address = params[:patient][:address]
    @patient.injury = params[:patient][:injury]
    @patient.infection = params[:patient][:infection]
    @patient.observations = params[:patient][:observations]
    @patient.cost = params[:patient][:cost]

    #create an instance/object of a BasicPatient
    myPatient = BasicPatient.new(@patient.cost)

    #add the extra requests to the new patient
    if params[:patient][:xray].to_s.length > 0 then myPatient = XrayDecorator.new(myPatient)
    end
    if params[:patient][:mri].to_s.length > 0 then myPatient = MriDecorator.new(myPatient)
    end
    if params[:patient][:cat].to_s.length > 0 then myPatient = CatDecorator.new(myPatient)
    end
    if params[:patient][:bloods].to_s.length > 0 then myPatient = BloodDecorator.new(myPatient)
    end

    # populate the request details and cost
    @patient.cost = myPatient.cost
    @patient.requests = myPatient.details
    #retrieve the instance/object of the PatientLogger class
    logger = PatientLogger.new()
    logger.logInformation("A new Patient added:" +@patient.fullname+ " With the following requests:" +@patient.requests)
    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: 'Patient was successfully created.' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  #########################################################################################################
    # PATCH/PUT /patients/1
    # PATCH/PUT /patients/1.json
    #Update instance variables with the new information
    def update

      @patient.fullname = params[:patient][:fullname]
      @patient.birthdate = params[:patient][:birthdate]
      @patient.telephone = params[:patient][:telephone]
      @patient.address = params[:patient][:address]
      @patient.infection = params[:patient][:infection]
      @patient.injury = params[:patient][:injury]
      @patient.observations = params[:patient][:observations]
    #  @patient.cost = params[:patient][:cost]


      myPatient = BasicPatient.new(@patient.cost)

      #add the extra requests to the new patient
      if params[:patient][:xray].to_s.length > 0 then myPatient = XrayDecorator.new(myPatient)
      end

      if params[:patient][:mri].to_s.length > 0 then myPatient = MriDecorator.new(myPatient)
      end

      if params[:patient][:cat].to_s.length > 0 then myPatient = CatDecorator.new(myPatient)
      end

      if params[:patient][:bloods].to_s.length > 0 then myPatient = BloodDecorator.new(myPatient)
      end

      # update the requests details and name
      @patient.cost = myPatient.cost

      @patient.requests = myPatient.details

      #build a hash with the updated information of the patient
      updated_information = {
        "fullname" => @patient.fullname,
        "birthdate" => @patient.birthdate,
        "telephone" => @patient.telephone,
        "address" => @patient.address,
        "infection" => @patient.infection,
        "injury" => @patient.injury,
        "observations" => @patient.observations,
        "cost" => @patient.cost,
        "requests" => @patient.requests
      }

    respond_to do |format|
      if @patient.update(updated_information)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end
############################################################################################################
  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:fullname, :birthdate, :telephone, :address, :infection, :injury, :observations, :cost, :requests)
    end
end
