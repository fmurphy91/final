# Observer Pattern for the xtra features such as xray, mri, bloods and CAT scan
# BasicPatient class
class BasicPatient
  def initialize(cost)
    @cost = cost
    @requests = "Basic Appointment charge"
  end

  # getter method
  def cost
    return @cost
  end

  # a method which returns a string representation of the object of type BasicPatient
  def details
    return  @requests + "; " + "#{@cost}"
  end

end # end the BasicPatient class

# PatientDecorator extends BasicPatient
class PatientDecorator < BasicPatient
  def initialize(basic_patient)
    @basic_patient = basic_patient
    super(@basic_patient.cost)
    @extra_cost = 0
    @requests = "No further"
  end

  # method which returns the cost of any additional decorator features and the basic_patient cost
  def cost
    return @extra_cost + @basic_patient.cost
 end

  # return the details of newly added features and cost
  def details
    return @requests + ": " + "#{@extra_cost}" + ". " + @basic_patient.details
  end

end #end the PatientDecorator class

# XrayDecorator class for xray option for user to choose with set cost
class XrayDecorator < PatientDecorator
  def initialize(basic_patient)
    super(basic_patient)
    @extra_cost = 80
    @requests = "Xray"
  end
end # end XrayDecorator class

# CatDecorator class for CAT option for user to choose with set cost
class CatDecorator < PatientDecorator
  def initialize(basic_patient)
    super(basic_patient)
    @extra_cost = 145
    @requests = "CAT (computerized axial tomography)"
  end
end # end CatDecorator class

# MriDecorator class for mri option for user to choose with set cost
class MriDecorator < PatientDecorator
  def initialize(basic_patient)
    super(basic_patient)
    @extra_cost = 100
    @requests = "MRI"
  end
end # end MriDecorator class

# BloodDecorator class for blood option for user to choose with set cost
class BloodDecorator < PatientDecorator
  def initialize(basic_patient)
    super(basic_patient)
    @extra_cost = 30
    @requests = "Bloods"
  end
end # end BloodDecorator class
