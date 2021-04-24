class c_103_2;
    rand bit[7:0] data_9_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_9_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_9_ != 8'hbc);
    }
endclass

program p_103_2;
    c_103_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xzz0z1xx0x1x1xx011x1z1100x010zx0xzxxxzzxxzxxzzzxxxzzxxzzzzzzxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
