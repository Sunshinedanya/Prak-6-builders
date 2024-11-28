using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
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
    /// Логика взаимодействия для LogisticsPage.xaml
    /// </summary>
    public partial class LogisticsPage : Page
    {
        public List<Employee> Employees { get; set; }
        public LogisticsPage()
        {
            InitializeComponent();
            LoadEmployees();
            LoadPositions();
            LoadProjects();
        }

        // Загрузка сотрудников из базы данных
        private void LoadEmployees()
        {
            Employees = DBConnector.DB.Employee.ToList();
            EmployeeListView.ItemsSource = Employees;

        }

        // Загрузка позиций для ComboBox
        private void LoadPositions()
        {
            PositionComboBox.ItemsSource = DBConnector.DB.Position.ToList();
        }

        private void LoadProjects()
        {
            ProjectComboBox.ItemsSource = DBConnector.DB.Project.ToList(); ;
        }

        // Добавить нового сотрудника
        private void AddEmployeeButton_Click(object sender, RoutedEventArgs e)
        {
            var newEmployee = new Employee
            {
                Name = NameTextBox.Text,
                Surname = SurnameTextBox.Text,
                PositionId = (PositionComboBox.SelectedItem as Position)?.id,
                DateOfBirth = DateOfBirthPicker.SelectedDate ?? DateTime.Now,
                WorkHours = int.TryParse(WorkHoursTextBox.Text, out int workHours) ? workHours : (int?)null
            };

            DBConnector.DB.Employee.Add(newEmployee);
            DBConnector.DB.SaveChanges();

            LoadEmployees(); // Перезагружаем список сотрудников
            ClearFields(); // Очищаем поля
            MessageBox.Show("Работник добавлен.");
        }

        // Изменить данные сотрудника
        private void UpdateEmployeeButton_Click(object sender, RoutedEventArgs e)
        {
            var selectedEmployee = EmployeeListView.SelectedItem as Employee;

            if (selectedEmployee == null)
            {
                MessageBox.Show("Выберите работника для изменения.");
                return;
            }

            selectedEmployee.Name = NameTextBox.Text;
            selectedEmployee.Surname = SurnameTextBox.Text;
            selectedEmployee.PositionId = (PositionComboBox.SelectedItem as Position)?.id;
            selectedEmployee.DateOfBirth = DateOfBirthPicker.SelectedDate ?? selectedEmployee.DateOfBirth;
            selectedEmployee.WorkHours = int.TryParse(WorkHoursTextBox.Text, out int workHours) ? workHours : selectedEmployee.WorkHours;
            selectedEmployee.CurrentProjectId = (ProjectComboBox.SelectedItem as Project)?.id;
            selectedEmployee.PerHourPayment = int.TryParse(SalaryTextBox.Text, out int salary) ? salary : selectedEmployee.PerHourPayment;


            Employees[selectedEmployee.id] = selectedEmployee;
            DBConnector.DB.SaveChanges();

            LoadEmployees(); // Перезагружаем список сотрудников
            MessageBox.Show("Работник обновлён.");
        }

        private void AssignEmployeeToProject(Employee employee, int newProjectId)
        {
            if (employee == null)
            {
                MessageBox.Show("Выберите работника из списка.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            // Находим сотрудника в базе данных
            var employeeToUpdate = DBConnector.DB.Employee.FirstOrDefault(e => e.id == employee.id);
            if (employeeToUpdate == null)
            {
                MessageBox.Show("Работник не найден в базе данных.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            // Создаем запись в таблице Salary для текущего проекта
            if (employeeToUpdate.CurrentProjectId != null)
            {
                var newSalary = new Salary
                {
                    EmployeeId = employeeToUpdate.id,
                    ProjectId = employeeToUpdate.CurrentProjectId.Value, // Проект, с которого переносим
                    PerHour = employeeToUpdate.WorkHours.HasValue ? employeeToUpdate.WorkHours.Value : 0,
                    Hours = employeeToUpdate.WorkHours ?? 0,
                    Total = (employeeToUpdate.WorkHours ?? 0) * employeeToUpdate.WorkHours.Value
                };
                DBConnector.DB.Salary.Add(newSalary);
            }

            // Обновляем текущий проект и обнуляем часы
            employeeToUpdate.CurrentProjectId = newProjectId;
            employeeToUpdate.WorkHours = 0;

            // Сохраняем изменения
            DBConnector.DB.SaveChanges();

            MessageBox.Show("Работник успешно перенесен на новый проект.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);

            // Обновляем интерфейс
            LoadEmployees(); // Загрузка данных работников (обновить ListView)

        }

        // Назначить работника на проект
        private void AssignEmployeeToProjectButton_Click(object sender, RoutedEventArgs e)
        {
            var selectedEmployee = EmployeeListView.SelectedItem as Employee;
            var selectedProject = ProjectComboBox.SelectedItem as Project;

            if (selectedEmployee == null)
            {
                MessageBox.Show("Выберите работника.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            if (selectedProject == null)
            {
                MessageBox.Show("Выберите проект.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            AssignEmployeeToProject(selectedEmployee, selectedProject.id);
        }

        // Выбор работника из ListView
        private void EmployeeListView_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var selectedEmployee = EmployeeListView.SelectedItem as Employee;

            if (selectedEmployee != null)
            {
                NameTextBox.Text = selectedEmployee.Name;
                SurnameTextBox.Text = selectedEmployee.Surname;
                PositionComboBox.SelectedItem = selectedEmployee.Position;
                DateOfBirthPicker.SelectedDate = selectedEmployee.DateOfBirth;
                WorkHoursTextBox.Text = selectedEmployee.WorkHours?.ToString();
                ProjectComboBox.SelectedItem = selectedEmployee.Project;
                SalaryTextBox.Text = selectedEmployee.PerHourPayment?.ToString();
            }
            else
            {
                ClearFields();
            }
        }

        // Очищаем текстовые поля
        private void ClearFields()
        {
            NameTextBox.Clear();
            SurnameTextBox.Clear();
            PositionComboBox.SelectedItem = null;
            DateOfBirthPicker.SelectedDate = null;
            WorkHoursTextBox.Clear();
            ProjectComboBox.SelectedItem = null;
            SalaryTextBox.Clear();
        }
    }
}
