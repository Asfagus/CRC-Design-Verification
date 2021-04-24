class c_85_2;
    rand bit[7:0] data_6_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_6_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_6_ != 8'hbc);
    }
endclass

program p_85_2;
    c_85_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zxx1x10101zx01xz1zz1z000xxzx11zzzzzxzxzzxxxxzxxxzxxzzzxzxzzzzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
