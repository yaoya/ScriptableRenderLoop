using System.Linq;
using NUnit.Framework;
using UnityEngine;
using UnityEditor.Graphing;

namespace UnityEditor.ShaderGraph.UnitTests
{
    [TestFixture]
    public class MaterialGraphTests
    {
        [OneTimeSetUp]
        public void RunBeforeAnyTests()
        {
            Debug.unityLogger.logHandler = new ConsoleLogHandler();
        }

        [Test]
        public void TestCreateMaterialGraph()
        {
            var graph = new ShaderGraph.MaterialGraph();

            Assert.IsNotNull(graph);

            Assert.AreEqual(0, graph.GetNodes<AbstractMaterialNode>().Count());
        }
    }
}
