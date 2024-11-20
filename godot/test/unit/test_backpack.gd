extends GutTest

func in_case(current, all, multiplier, expected):
	Backpack.current_level = current
	Backpack.size_of_levels = all
	Backpack.mob_speed_multiplier = multiplier
	assert_eq(
		Backpack.mob_speed(), expected, 
		"Level " + 
		str(current) + "/" + 
		str(all) + 
		" with " + str(multiplier)
	)

func test_assert_first_round():
	in_case(0, 3, 1.2, 1.0)
	in_case(2, 3, 1.2, 1.0)
	in_case(3, 5, 5.2, 1.0)

func test_assert_2nd_round():
	in_case(3, 3, 1.2, 1.2)
	in_case(5, 3, 1.2, 1.2)
	in_case(8, 5, 5.2, 5.2)

func test_assert_3rd_round():
	in_case(6, 3, 1.2, 1.44)
	in_case(8, 3, 1.2, 1.44)
	in_case(12, 5, 5, 25)

func test_assert_nth_round():
	in_case(6, 1, 2, 64)
	in_case(8, 1, 2, 256)
	in_case(2, 1, 3, 9)
	in_case(4, 2, 3, 9)
	in_case(6, 2, 3, 27)
