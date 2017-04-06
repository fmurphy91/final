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

class PatientDecorator < BasicPatient
  def initialize(basic_patient)
    @basic_patient = basic_patient
    super(@basic_patient.cost)
    @extra_cost = 0
    @requests = "No further"
  end

  def cost
    return @extra_cost + @basic_patient.cost
 end

  def details
    return @requests + ": " + "#{@extra_cost}" + ". " + @basic_patient.details
  end

end #end the PatientDecorator class

class XrayDecorator < PatientDecorator
  def initialize(basic_patient)
    super(basic_patient)
    @extra_cost = 80
    @requests = "Xray"
  end
end # end XrayDecorator class

class CatDecorator < PatientDecorator
  def initialize(basic_patient)
    super(basic_patient)
    @extra_cost = 145
    @requests = "CAT (computerized axial tomography)"
  end
end # end CatDecorator class

class MriDecorator < PatientDecorator
  def initialize(basic_patient)
    super(basic_patient)
    @extra_cost = 100
    @requests = "MRI"
  end
end # end MriDecorator class


class BloodDecorator < PatientDecorator
  def initialize(basic_patient)
    super(basic_patient)
    @extra_cost = 30
    @requests = "Bloods"
  end
end # end BloodDecorator class
