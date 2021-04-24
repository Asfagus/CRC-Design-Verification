class c_88_2;
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

program p_88_2;
    c_88_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0x0zzx0z00zz00zzx00zxz1x101100x0xxxzzzzxzzzxxzzzxxzxxxxxxzxzxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
