class c_139_2;
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

program p_139_2;
    c_139_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z001z1zxzz1010z1x0x0z00x0zz0zzzxxxxxxxxxxzxxxzxxxzxxzzzxzxzxzxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
