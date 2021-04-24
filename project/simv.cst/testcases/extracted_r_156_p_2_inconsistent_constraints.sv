class c_156_2;
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

program p_156_2;
    c_156_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "01zz01xz001zxz000111xx1xzxxxxzx1zxzzzxzxxzxzzzxxxzzxxxxzzzzxxzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
