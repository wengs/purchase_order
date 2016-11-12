Milestone::NAMES.sort.each { |key| Milestone.where(name: key).first_or_create }
Role::DEFINED_ROLES.each { |key| Role.where(name: key).first_or_create }
User.where(name: "Admin").first_or_create(email: "admin@mail.com", password: "password", role_id: Role.where(name: 'admin').first.id)
[
'3M 3555 ABV',
'Window Deco White ABV',
'Busmark ABV',
'3mm White Dibond' ,
'3mm Brushed Aluminum Dibond',
'Block out Standard Banner Vinyl',
'Banner Stands (supplied vs purchased)',
'Front Lit Standard Banner Vinyl',
'Dyesub GF8864',
'Dyesub GF 4480',
'040 White Styrene',
'Duarte 7mil Backlit'
].each do |substrate|
  Substrate.where(name: substrate).first_or_create
end
[
  'Single Sided',
  'Double Sided'
].each do |side|
  Side.where(name: side).first_or_create
end