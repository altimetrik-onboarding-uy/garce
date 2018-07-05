global class ScheduleSubmit implements Schedulable{

    public static String sched = '0 00 00 * * ?';  //Every Day at Midnight 

    

    global void execute(SchedulableContext sc) {

        SubmitBatch batch1 = new SubmitBatch();
        ID batchprocessid = Database.executeBatch(batch1,200);           
    }
}