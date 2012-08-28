public class ScheduledJobManagerController
{
    public static void startJob()
    {
        RegeneratingScheduledJobProcessor.scheduleNextRun();
    }
}