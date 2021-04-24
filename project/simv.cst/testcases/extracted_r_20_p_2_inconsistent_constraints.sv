class c_20_2;
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

program p_20_2;
    c_20_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xxzz0zz0xz0x1z101z0x1xx10xxz00zzzzxzzzzzzxxxzxzzzzzxxxzxxxxxxxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
