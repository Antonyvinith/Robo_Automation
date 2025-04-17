import pandas as pd


def scan_excel_file(file_path):
    try:
        # Read the Excel file into a pandas DataFrame
        df = pd.read_excel(file_path)

        df.to_string(index=False)

    except FileNotFoundError:
        print(f"Error: The file '{file_path}' was not found.")
    except Exception as e:
        print(f"Error: An unexpected error occurred: {str(e)}")


def main():
    # Specify the path to your Excel file
    excel_file_path = "BCI Files (ACA LD MD) 12-24-24_LightDuty.xlsx"  # Replace with your actual file path

    # Call the function to scan the Excel file
    scan_excel_file(excel_file_path)


if __name__ == "__main__":
    main()

