# typed: strict
# create test projects
pa = Project.create(:name => "Test project A")
pb = Project.create(:name => "Test project B")

# create test items

Item.create(
	:description => "test item project A, stage 1",
	:stage => 1,
	:project => pa
)

Item.create(
	:description => "test item project A, stage 2",
	:stage => 2,
	:project => pa
)

Item.create(
	:description => "test item project A, stage 3",
	:stage => 3,
	:project => pa
)

Item.create(
	:description => "test item project B, stage 1",
	:stage => 1,
	:project => pb
)

Item.create(
	:description => "test item project B, stage 2",
	:stage => 2,
	:project => pb
)

Item.create(
	:description => "test item project B, stage 3",
	:stage => 3,
	:project => pb
)