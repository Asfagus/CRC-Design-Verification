class c_144_2;
    rand bit[7:0] data_7_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_7_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_7_ != 8'hbc);
    }
endclass

program p_144_2;
    c_144_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xx10xz00zz0x010xzx0zz1xxzzx1xz0xxzzzxzxzxzzzzzzzxxzzxzzzzxzzzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
