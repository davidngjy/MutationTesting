using FluentAssertions;
using MutationTesting.Web.Processes;
using Xunit;

namespace MutationTesting.Web.Test.UnitTests
{
	public class CalculatorTests
	{
		[Fact]
		public void TestSum()
		{
			// Arrange
			var calculator = new Calculator();

			// Act
			var result = calculator.Sum(1, 1);

			// Assert
			result.Should().Be(2);
		}

		[Fact]
		public void TestMinus()
		{
			// Arrange
			var calculator = new Calculator();

			// Act
			var result = calculator.Minus(1, 1);

			// Assert
			result.Should().Be(0);
		}

		[Fact]
		public void TestMultiply()
		{
			// Arrange
			var calculator = new Calculator();

			// Act
			var result = calculator.Multiply(1, 1);

			// Assert
			result.Should().Be(1);
		}

		[Fact]
		public void TestDivide()
		{
			// Arrange
			var calculator = new Calculator();

			// Act
			var result = calculator.Divide(1, 1);

			// Assert
			result.Should().Be(1);
		}
	}
}