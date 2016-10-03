var widgetDefinitions = [
    {
        widgetTitle: "CPU信息",
        widgetId: "wg_cpu",
        widgetContent: $('#cpuinfo'),
    },
    {
        widgetTitle: "CPU信息",
        widgetId: "wg_cpu1",
        widgetContent: $('#cpuinfo1'),
    },
]

$("#myDashboard").sDashboard({
    dashboardData: widgetDefinitions
});