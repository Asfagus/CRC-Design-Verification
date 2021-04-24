class c_93_2;
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

program p_93_2;
    c_93_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1x1xx111x0zxxxz0010x11xxzz00x11zzxxzzzzzzzzzzzxzxxzxzxxzzxxxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
