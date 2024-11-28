using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using WpfApp1.DB;

namespace WpfApp1
{
    /// <summary>
    /// Логика взаимодействия для DeadlinesPage.xaml
    /// </summary>
    public partial class DeadlinesPage : Page
    {
        private List<ProjectTask> tasks = new List<ProjectTask>();
        private List<Project> projects = new List<Project>();
        private int selectedProjectId;

        public DeadlinesPage()
        {
            InitializeComponent();
            LoadProjects();
        }

        private void LoadProjects()
        {    
            projects = DBConnector.DB.Project.ToList();
            ProjectComboBox.ItemsSource = projects;
            ProjectComboBox.DisplayMemberPath = "name"; // Отображаем имя проекта
            ProjectComboBox.SelectedValuePath = "id";  // Используем Id проекта   
        }

        private void LoadTasks()
        {
            tasks = DBConnector.DB.ProjectTask
                           .Where(task => task.ProjectId == selectedProjectId)
                           .ToList();
            TaskListView.ItemsSource = tasks;
        }

        private void ProjectComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (ProjectComboBox.SelectedItem is Project selectedProject)
            {
                selectedProjectId = selectedProject.id;
                LoadTasks();
            }
        }

        private void AddTaskButton_Click(object sender, RoutedEventArgs e)
        {
            var newTask = new ProjectTask
            {
                Name = "Новая задача",
                StartDate = DateTime.Now,
                EndDate = DateTime.Now.AddDays(7),
                Descrition = "Описание задачи",
                ProjectId = selectedProjectId
            };

            DBConnector.DB.ProjectTask.Add(newTask);
            DBConnector.DB.SaveChanges();

            tasks.Add(newTask);
            TaskListView.Items.Refresh();
        }

        private void TaskListView_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (TaskListView.SelectedItem is ProjectTask selectedTask)
            {
                TaskNameTextBox.Text = selectedTask.Name;
                TaskDescriptionTextBox.Text = selectedTask.Descrition;
                TaskStartDatePicker.SelectedDate = selectedTask.StartDate;
                TaskEndDatePicker.SelectedDate = selectedTask.EndDate;
            }
        }

        private void SaveTaskButton_Click(object sender, RoutedEventArgs e)
        {
            if (TaskListView.SelectedItem is ProjectTask selectedTask)
            {
                selectedTask.Name = TaskNameTextBox.Text;
                selectedTask.Descrition = TaskDescriptionTextBox.Text;
                selectedTask.StartDate = TaskStartDatePicker.SelectedDate ?? DateTime.Now;
                selectedTask.EndDate = TaskEndDatePicker.SelectedDate ?? DateTime.Now.AddDays(1);

                DBConnector.DB.Entry(selectedTask).State = System.Data.Entity.EntityState.Modified;
                DBConnector.DB.SaveChanges();
                
                TaskListView.Items.Refresh();
            }
        }

        private void BuildGanttChartButton_Click(object sender, RoutedEventArgs e)
        {
            GanttChartCanvas.Children.Clear();

            double chartWidth = GanttChartCanvas.ActualWidth;
            double chartHeight = GanttChartCanvas.ActualHeight;

            double taskHeight = chartHeight / tasks.Count;

            foreach (var task in tasks)
            {
                double taskStart = (task.StartDate.Value - DateTime.Now).TotalDays;
                double taskEnd = (task.EndDate.Value - DateTime.Now).TotalDays;

                // Normalize task position on chart
                double startX = Math.Max(0, taskStart * 20); // Scale: 20 px per day
                double taskWidth = Math.Max(0, (taskEnd - taskStart) * 20);

                // Create rectangle for task
                var taskRectangle = new Rectangle
                {
                    Width = taskWidth,
                    Height = taskHeight - 5,
                    Fill = new SolidColorBrush(Colors.LightBlue),
                    Stroke = new SolidColorBrush(Colors.DarkBlue),
                    StrokeThickness = 1
                };

                Canvas.SetLeft(taskRectangle, startX);
                Canvas.SetTop(taskRectangle, tasks.IndexOf(task) * taskHeight);

                // Add to canvas
                GanttChartCanvas.Children.Add(taskRectangle);

                // Add task name
                var taskNameText = new TextBlock
                {
                    Text = task.Name,
                    Foreground = new SolidColorBrush(Colors.Black),
                    FontSize = 12
                };

                Canvas.SetLeft(taskNameText, startX + 5);
                Canvas.SetTop(taskNameText, tasks.IndexOf(task) * taskHeight + 5);

                GanttChartCanvas.Children.Add(taskNameText);
            }
        }
    }
}
