class c_3_2;
    rand bit[7:0] data_5_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_5_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_5_ != 8'hbc);
    }
endclass

program p_3_2;
    c_3_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "10z010zxzz1100x11z00110xxx11z1xzzzxxzzzzxzzxzzzxzxxzzzzxzzxxxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
