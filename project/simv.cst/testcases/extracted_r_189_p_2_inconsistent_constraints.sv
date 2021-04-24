class c_189_2;
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

program p_189_2;
    c_189_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0z010xz1x0z1xzz1xz10z0xz1111x110zzzxxzxxxxxzzzxxzzxxxxzxxzxxxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
