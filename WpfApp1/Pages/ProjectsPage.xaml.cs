using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using WpfApp1.DB;

namespace WpfApp1
{
    /// <summary>
    /// Логика взаимодействия для ProjectsPage.xaml
    /// </summary>
    public partial class ProjectsPage : Page
    {
        public List<Project> Projects { get; set; }
        public Project Project { get; set; }
        public ProjectsPage()
        {
            InitializeComponent();
            Projects = DBConnector.DB.Project.ToList();
            DataContext = this;
        }   

        // Метод очистки текстовых полей
        private void ClearFields()
        {
            NameTextBox.Text = string.Empty;
            CustomerIdTextBox.Text = string.Empty;
            TypeIdTextBox.Text = string.Empty;
            EndDatePicker.SelectedDate = null;
            ProjectStateIdTextBox.Text = string.Empty;
        }

        private void AddProject(Project project)
        {
            DBConnector.DB.Project.Add(project);
            DBConnector.DB.SaveChanges();
        }

        private void LoadProjects()
        {
            Projects = DBConnector.DB.Project.ToList();
            DataContext = this;
        }

        private void LoadProjectEstimates(int projectId)
        {
            var projectEstimates = DBConnector.DB.ProjectEstimate
                                          .Where(pe => pe.ProjectId == projectId)
                                          .ToList();

            EstimateListView.ItemsSource = projectEstimates;
        }

        private void ListView_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var selectedProject = (sender as ListView)?.SelectedItem as Project;

            if (selectedProject != null)
            {
                // Обновляем текстовые поля
                IdTextBox.Text = selectedProject.id.ToString();
                NameTextBox.Text = selectedProject.name;
                CustomerIdTextBox.Text = selectedProject.CustomerId.ToString();
                TypeIdTextBox.Text = selectedProject.TypeId.ToString();
                EndDatePicker.SelectedDate = selectedProject.EndDate;
                ProjectStateIdTextBox.Text = selectedProject.ProjectStateId?.ToString() ?? string.Empty;

                LoadProjectEstimates(selectedProject.id);
            }
            else
            {
                ClearFields();
                EstimateListView.ItemsSource = null;
            }
        }

        private void AddProjectButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Создаём новый проект из данных в текстовых полях
                var newProject = new Project
                {
                    name = NameTextBox.Text,
                    CustomerId = int.TryParse(CustomerIdTextBox.Text, out int customerId) ? customerId : 0,
                    TypeId = int.TryParse(TypeIdTextBox.Text, out int typeId) ? typeId : 0,
                    EndDate = EndDatePicker.SelectedDate,
                    ProjectStateId = int.TryParse(ProjectStateIdTextBox.Text, out int projectStateId) ? projectStateId : 100
                };

                AddProject(newProject);

                ClearFields();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при добавлении проекта: {ex.Message}");
            }

            LoadProjects();
        }

        private void UpdateProjectButton_Click(object sender, RoutedEventArgs e)
        {
            // Проверяем, есть ли выбранный проект
            var selectedProject = Projects.FirstOrDefault(p =>
            {
                int.TryParse(IdTextBox.Text, out int id);
                return p.id == id;
            });

            if (selectedProject != null)
            {
                try
                {
                    // Обновляем свойства выбранного проекта
                    selectedProject.name = NameTextBox.Text;
                    selectedProject.CustomerId = int.TryParse(CustomerIdTextBox.Text, out int customerId) ? customerId : selectedProject.CustomerId;
                    selectedProject.TypeId = int.TryParse(TypeIdTextBox.Text, out int typeId) ? typeId : selectedProject.TypeId;
                    selectedProject.EndDate = EndDatePicker.SelectedDate; // Обновляем дату
                    selectedProject.ProjectStateId = int.TryParse(ProjectStateIdTextBox.Text, out int projectStateId) ? projectStateId : selectedProject.ProjectStateId;

                    // Обновление интерфейса
                    var selectedIndex = Projects.IndexOf(selectedProject);
                    Projects[selectedIndex] = selectedProject; // Перезаписываем в коллекции

                    DBConnector.DB.SaveChanges();
                    MessageBox.Show("Проект успешно обновлён!");
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Ошибка при изменении проекта: {ex.Message}");
                }
            }
            else
            {
                MessageBox.Show("Выберите проект для изменения.");
            }

            LoadProjects();
        }       
    }
}
