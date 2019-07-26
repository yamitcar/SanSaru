class Role
  attr_reader :name

  def self.all
    [
      new('Dev Sr', 10, 15),
      new('Dev Jr', 20, 22),
      new('UX/UI Designer', 7, 10),
      new('Scrum Master', 7, 10),
      new('Testing', 5, 5),
      new('Product Owner', 15, 15),
    ]
  end

  def initialize(name, ideal_quota, quota)
    @name = name
    @ideal_quota = ideal_quota
    @quota = quota
  end
end