class c_173_2;
    rand bit[7:0] data_8_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_8_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_8_ != 8'hbc);
    }
endclass

program p_173_2;
    c_173_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x10111zzzxzx0x0xx11z101zx101zxxxxxzzzzzzxxzxzxxzxxxxxxzxxzxxzxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
