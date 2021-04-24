class c_55_2;
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

program p_55_2;
    c_55_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z0zz00z1zz100x101z10011x1110xxz1xzzzzzzzzzxxxzzzxzzzxzzzxzxzzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
