extends "res://unittest.gd"

func tests():
    testcase("sample test")
    print("testing the sample test")
    #assert_false(board.check_placement(0, 0), 'near top left corner')
    assert_true(1==1, "should be true")
    endcase()