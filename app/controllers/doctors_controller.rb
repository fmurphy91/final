require 'doctor_logger'
class DoctorsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_admin, :only  => [:destroy]
  before_action :set_doctor, only: [:show, :edit, :update, :destroy]

  # GET /doctors
  # GET /doctors.json
  def index
    @doctors = Doctor.all
    @doctors = Doctor.order("user_id")
    if params[:search]
      @doctors = Doctor.search(params[:search])
      @doctors = @doctors.order("created_at ASC")
    else
      @doctors = @doctors.order("created_at DESC")
    end
  end

  # GET /doctors/1
  # GET /doctors/1.json
  def show
  end

  # GET /doctors/new
  def new
    @doctor = Doctor.new
    @doctor.user_id = current_user.id
    respond_to do |format|
      format.html # new.html.erb
      format.json {
        render json: @doctor } end
      end

      def signedinuserdoctor doctor =
        Doctor.find_by_user_id(current_user.id)
        if doctor.nil?
          redirect_to "/doctors/new"
        else
          @doctor = Doctor.find_by_user_id(current_user.id)
          redirect_to "/doctors/#{@doctor.id}" end
        end

        def ensure_admin
          unless current_user && current_user.admin?
            render :text => "Access Error Message", :status => :unauthorized
          end
        end

        # GET /doctors/1/edit
        def edit
        end

        # POST /doctors
        # POST /doctors.json
        def create
          @doctor = Doctor.new()
          @doctor.firstname = params[:doctor][:firstname]
          @doctor.lastname = params[:doctor][:lastname]
          @doctor.phone = params[:doctor][:phone]
          @doctor.address = params[:doctor][:address]
          @doctor.consultation = params[:doctor][:consultation]
          @doctor.user_id = params[:doctor][:user_id]
          @doctor.poster = params[:doctor][:poster]
          myDoctor = Doctor.new()
          logger = DoctorLogger.new()
          #add new Doctor users to the doctorlog.txt file Firstname, lastname and the current_user's email
          logger.logInformation("Dr." +@doctor.firstname+" "+@doctor.lastname+" has been added as a user "+@doctor.user.email)
          respond_to do |format|
            if @doctor.save
              format.html { redirect_to @doctor, notice: 'Doctor was successfully created.' }
              format.json { render :show, status: :created, location: @doctor }
            else
              format.html { render :new }
              format.json { render json: @doctor.errors, status: :unprocessable_entity }
            end
          end
        end

        # PATCH/PUT /doctors/1
        # PATCH/PUT /doctors/1.json
        def update
          respond_to do |format|
            if @doctor.update(doctor_params)
              format.html { redirect_to @doctor, notice: 'Doctor was successfully updated.' }
              format.json { render :show, status: :ok, location: @doctor }
            else
              format.html { render :edit }
              format.json { render json: @doctor.errors, status: :unprocessable_entity }
            end
          end
        end

        # DELETE /doctors/1
        # DELETE /doctors/1.json
        def destroy
          @doctor.destroy
          respond_to do |format|
            format.html { redirect_to doctors_url, notice: 'Doctor was successfully destroyed.' }
            format.json { head :no_content }
          end
        end

        private
        # Use callbacks to share common setup or constraints between actions.
        def set_doctor
          @doctor = Doctor.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def doctor_params
          params.require(:doctor).permit(:firstname, :lastname, :phone, :address, :consultation, :user_id, :poster)
        end
      end
